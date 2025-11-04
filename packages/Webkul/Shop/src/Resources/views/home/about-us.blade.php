<!-- Page Layout -->
<x-shop::layouts>
    <!-- Page Title -->
    <x-slot name="title">
        About Us
    </x-slot>

    <div class="container mt-8 max-1180:px-5 max-md:mt-6 max-md:px-4">
        <div class="m-auto w-full max-w-[870px] rounded-xl border border-zinc-200 p-16 px-[90px] max-md:px-8 max-md:py-8 max-sm:border-none max-sm:p-0">
            <h1 class="font-dmserif text-4xl max-md:text-3xl max-sm:text-xl">About Us</h1>

            <div class="prose mt-6 max-w-none text-zinc-700">
                <p>
                    Welcome to {{ config('app.name') }}. We’re passionate about offering quality products and a smooth shopping experience.
                </p>
                <p>
                    This is a placeholder About Us page. You can edit this content in
                    <code>packages/Webkul/Shop/src/Resources/views/home/about-us.blade.php</code>.
                </p>
            </div>
        </div>
    </div>
</x-shop::layouts>
