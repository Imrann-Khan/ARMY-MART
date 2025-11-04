@php
    $channel = core()->getCurrentChannel();
@endphp

<!-- SEO Meta Content -->
@push ('meta')
    <meta
        name="title"
        content="{{ $channel->home_seo['meta_title'] ?? '' }}"
    />

    <meta
        name="description"
        content="{{ $channel->home_seo['meta_description'] ?? '' }}"
    />

    <meta
        name="keywords"
        content="{{ $channel->home_seo['meta_keywords'] ?? '' }}"
    />
@endPush

<x-shop::layouts>
    <!-- Page Title -->
    <x-slot:title>
        {{  $channel->home_seo['meta_title'] ?? '' }}
    </x-slot>
    
    <!-- Loop over the theme customization -->
    @foreach ($customizations as $customization)
        @php ($data = $customization->options) @endphp

        <!-- Static content -->
        @switch ($customization->type)
            @case ($customization::IMAGE_CAROUSEL)
                <!-- Image Carousel -->
                <x-shop::carousel
                    :options="$data"
                    aria-label="{{ trans('shop::app.home.index.image-carousel') }}"
                />

                @break
            @case ($customization::STATIC_CONTENT)
                <!-- push style -->
                @if (! empty($data['css']))
                    @push ('styles')
                        <style>
                            {{ $data['css'] }}
                        </style>
                    @endpush
                @endif

                <!-- render html -->
                @if (! empty($data['html']))
                    @php
                        $html = $data['html'];
                        $appUrl = rtrim(config('app.url'), '/');

                        // Helper: starts-with for multiple prefixes (compatible with older PHP)
                        $startsWith = function ($value, array $prefixes) {
                            foreach ($prefixes as $p) {
                                if (strncmp($value, $p, strlen($p)) === 0) {
                                    return true;
                                }
                            }
                            return false;
                        };

                        // Rewrite href/src links that point to localhost/127.0.0.1 or contain Blade-like url() helpers
                        // Case-insensitive on href/src
                        $html = preg_replace_callback('/\b(href|src)=(\"|\')([^\"\']+)(\2)/i', function ($m) use ($appUrl, $startsWith) {
                            $attr = $m[1];
                            $quote = $m[2];
                            $value = trim($m[3]);

                            $original = $value;

                            // If value is percent-encoded (e.g., %7B%7B url('/clothes') %7D%7D), decode first
                            $decoded = rawurldecode($value);
                            if ($decoded !== '' && $decoded !== $value) {
                                $value = $decoded;
                            }

                            // If wrapped in Blade moustache {{ ... }}, strip wrappers
                            if (preg_match('/^\s*\{\{\s*(.*?)\s*\}\}\s*$/', $value, $mm)) {
                                $value = $mm[1] ?? $value;
                            }

                            // Extract Blade-like url('/path') if present inside attribute value
                            if (preg_match("/url\\((['\"])\s*(.*?)\s*\\1\\)/", $value, $mm)) {
                                $value = $mm[2] ?? $value;
                            }

                            // If protocol-relative or full URL (non-localhost), keep as-is
                            if ($startsWith($value, ['http://', 'https://', '//'])) {
                                $parsed = @parse_url($value);

                                if (! $parsed || empty($parsed['host']) || ! in_array($parsed['host'], ['localhost', '127.0.0.1'])) {
                                    return $attr . '=' . $quote . $original . $quote;
                                }
                            }

                            // For localhost/127 or relative paths, normalize against APP_URL
                            $parsed = @parse_url($value);
                            $path = $parsed['path'] ?? $value;

                            if (! $startsWith($path, ['/'])) {
                                $path = '/' . ltrim($path, '/');
                            }

                            // If it's a single-segment path like "/clothes" or "/shoes", force it to the desired search URL
                            if (preg_match('#^/[A-Za-z0-9\-]+$#', $path)) {
                                $normalized = route('shop.search.index', ['featured' => 1, 'sort' => 'name-desc']);
                            } else {
                                $normalized = $appUrl . $path;
                            }

                            return $attr . '=' . $quote . $normalized . $quote;
                        }, $html);
                    @endphp

                    {!! $html !!}
                @endif

                @break
            @case ($customization::CATEGORY_CAROUSEL)
                <!-- Categories carousel -->
                <x-shop::categories.carousel
                    :title="$data['title'] ?? ''"
                    :src="route('shop.api.categories.index', $data['filters'] ?? [])"
                    :navigation-link="route('shop.home.index')"
                    aria-label="{{ trans('shop::app.home.index.categories-carousel') }}"
                />

                @break
            @case ($customization::PRODUCT_CAROUSEL)
                <!-- Product Carousel -->
                <x-shop::products.carousel
                    :title="$data['title'] ?? ''"
                    :src="route('shop.api.products.index', $data['filters'] ?? [])"
                    :navigation-link="route('shop.search.index', $data['filters'] ?? [])"
                    aria-label="{{ trans('shop::app.home.index.product-carousel') }}"
                />

                @break
        @endswitch
    @endforeach
</x-shop::layouts>
