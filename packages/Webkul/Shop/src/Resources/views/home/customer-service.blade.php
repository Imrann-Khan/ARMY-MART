<!-- Page Layout -->
<x-shop::layouts>
    <!-- Page Title -->
    <x-slot:title>
        Customer Service
    </x-slot>

    <div class="container mt-8 max-1180:px-5 max-md:mt-6 max-md:px-4">
        <div class="m-auto w-full max-w-[870px] rounded-xl border border-zinc-200 p-16 px-[90px] max-md:px-8 max-md:py-8 max-sm:border-none max-sm:p-0">
            <h1 class="font-dmserif text-4xl max-md:text-3xl max-sm:text-xl">Customer Service</h1>

            <div class="prose mt-6 max-w-none text-zinc-700">
                <p>
                    Need help with your order, returns, or product questions? Our team is here to assist you.
                </p>
                <p>
                    You can reach us via the <a href="{{ route('shop.home.contact_us') }}" class="text-blue-700 underline">contact form</a> or email us at {{ config('mail.from.address') ?? 'shop@example.com' }}.
                </p>
                <p class="mt-4">
                    Edit this page in <code>packages/Webkul/Shop/src/Resources/views/home/customer-service.blade.php</code>.
                </p>
            </div>
        </div>
    </div>
</x-shop::layouts>
