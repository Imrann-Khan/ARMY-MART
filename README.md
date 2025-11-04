# Deploying Army Mart

This zip includes the Laravel/Bagisto project and a MySQL dump of the current database so someone else can run it locally.

## Prerequisites
- PHP (matching the project requirements)
- Composer
- MySQL (XAMPP or standalone)
- Node.js + npm (optional if you need to run Vite builds)

## Quick Start
1. Extract the zip to your web root (e.g., `C:/xampp/htdocs/army-mart`).
2. Create a MySQL database (same name used in the dump, default: `army_db`).
3. Import the dump file:
   - File location: `storage/exports/<dbname>_<timestamp>.sql`
   - Example (Windows PowerShell):
     - Start MySQL shell and run:
       ```sql
       SOURCE C:/xampp/htdocs/army-mart/storage/exports/army_db_YYYYMMDD-HHMMSS.sql;
       ```
4. Copy `.env.example` to `.env` (or use the existing `.env` if present) and set DB credentials.
5. Install PHP dependencies:
   ```powershell
   composer install
   ```
6. Generate app key (only if not already set):
   ```powershell
   php artisan key:generate
   ```
7. Storage symlink:
   ```powershell
   php artisan storage:link
   ```
8. Cache config/routes/views (optional but recommended):
   ```powershell
   php artisan config:cache
   php artisan route:cache
   php artisan view:cache
   ```
9. Start the app (use your preferred method):
   ```powershell
   php artisan serve
   ```
   Or via Apache/Nginx pointing to `public/`.

## Frontend (optional)
If you need to build frontend assets (Vite):
```powershell
npm install
npm run build
```

## Notes
- The `vendor/` and `node_modules/` folders are excluded to keep the zip small. Run `composer install` and, if needed, `npm install` locally.
- The database dump mirrors the state at packaging time. If the DB name differs, create a DB with the name in `.env` and import accordingly.
- If your `.env` contains secrets, rotate or replace them before sharing the project externally.
