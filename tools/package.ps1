param(
    [string]$ZipName,
    [string]$DbName = "army_db",
    [string]$MysqlBin = "C:\\xampp\\mysql\\bin",
    [string]$MysqlUser = "root",
    [securestring]$MysqlPassword
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Resolve repo root (tools folder is one level below root)
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$date = Get-Date -Format "yyyyMMdd-HHmmss"

if (-not $ZipName -or [string]::IsNullOrWhiteSpace($ZipName)) {
    $ZipName = "army-mart-$date.zip"
}

$distDir = Join-Path $repoRoot "dist"
$tempStage = Join-Path $env:TEMP "army-mart-stage-$date"
$exportDir = Join-Path $repoRoot "storage/exports"
$dumpPath = Join-Path $exportDir ("${DbName}_$date.sql")
$zipPath = Join-Path $distDir $ZipName

# Ensure directories
New-Item -ItemType Directory -Force -Path $distDir | Out-Null
New-Item -ItemType Directory -Force -Path $exportDir | Out-Null

# 1) Export database
Write-Host "[1/3] Exporting database '$DbName' to $dumpPath" -ForegroundColor Cyan
$mysqldumpExe = Join-Path $MysqlBin "mysqldump.exe"
if (-not (Test-Path $mysqldumpExe)) {
    throw "mysqldump.exe not found at '$mysqldumpExe'. Update -MysqlBin to your XAMPP MySQL bin folder."
}

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $mysqldumpExe
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true

$procArgs = @("-u$MysqlUser", "--databases", $DbName, "--add-drop-database")
if ($MysqlPassword) {
    $plainPwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($MysqlPassword))
    if ($plainPwd -and -not [string]::IsNullOrWhiteSpace($plainPwd)) {
        $procArgs = @("-u$MysqlUser", "-p$plainPwd", "--databases", $DbName, "--add-drop-database")
    }
}
$psi.Arguments = ($procArgs -join ' ')

$proc = [System.Diagnostics.Process]::Start($psi)
$stdout = $proc.StandardOutput.ReadToEnd()
$stderr = $proc.StandardError.ReadToEnd()
$proc.WaitForExit()

if ($proc.ExitCode -ne 0 -and [string]::IsNullOrWhiteSpace($stdout)) {
    throw "mysqldump failed with exit code $($proc.ExitCode): $stderr"
}

$stdout | Set-Content -Path $dumpPath -Encoding UTF8
Write-Host "    Dumped: $dumpPath" -ForegroundColor Green

# 2) Stage files to temp outside repo (exclude heavy/generated)
Write-Host "[2/3] Staging files (excluding modules and caches)" -ForegroundColor Cyan

# Clean temp stage if exists
if (Test-Path $tempStage) { Remove-Item -Recurse -Force $tempStage }
New-Item -ItemType Directory -Force -Path $tempStage | Out-Null

# Exclude directories (relative to repo root)
$excludeDirs = @(
    "node_modules",
    "vendor",
    ".git",
    ".idea",
    ".vscode",
    "storage\\framework",
    "storage\\logs",
    "bootstrap\\cache",
    "public\\build",
    "public\\cache",
    "dist"
)

# Build absolute exclude list for robocopy /XD
$excludeDirsAbs = $excludeDirs | ForEach-Object { Join-Path $repoRoot $_ }

# Use robocopy to mirror while excluding heavy dirs
$rcArgs = @(
    $repoRoot,
    $tempStage,
    "/MIR",
    "/NFL","/NDL","/NJH","/NJS","/NP",
    "/XD"
) + $excludeDirsAbs

# Run robocopy (present on Windows). Fallback to Copy-Item if it fails.
Start-Process -PassThru -NoNewWindow -FilePath "robocopy" -ArgumentList $rcArgs -Wait | Out-Null
$code = $LASTEXITCODE
Write-Host "    robocopy exit code: $code" -ForegroundColor DarkGray
if ($code -gt 1) {
    Write-Warning "robocopy failed (code $code). Falling back to PowerShell copy."
    $excludePatterns = @(
        "*\\node_modules\\*",
        "*\\vendor\\*",
        "*\\.git\\*",
        "*\\.idea\\*",
        "*\\.vscode\\*",
        "*\\storage\\framework\\*",
        "*\\storage\\logs\\*",
        "*\\bootstrap\\cache\\*",
        "*\\public\\build\\*",
        "*\\public\\cache\\*",
        "*\\dist\\*"
    )

    Get-ChildItem -Path $repoRoot -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $full = $_.FullName
        $exclude = $false
        foreach ($pat in $excludePatterns) {
            if ($full -like $pat) { $exclude = $true; break }
        }
        if (-not $exclude) {
            $dest = $full -replace [regex]::Escape($repoRoot), $tempStage
            $destDir = Split-Path -Parent $dest
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
            Copy-Item -Path $full -Destination $dest -Force
        }
    }
}

# 3) Create zip in repo/dist
Write-Host "[3/3] Creating zip at $zipPath" -ForegroundColor Cyan
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
Compress-Archive -Path (Join-Path $tempStage '*') -DestinationPath $zipPath -Force
Write-Host "    Zip created: $zipPath" -ForegroundColor Green

# Cleanup temp stage
Remove-Item -Recurse -Force $tempStage

Write-Host "Done. Ship the zip and database dump (storage/exports)." -ForegroundColor Green
$global:LASTEXITCODE = 0
