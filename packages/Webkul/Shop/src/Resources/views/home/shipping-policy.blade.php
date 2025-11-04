<!-- Page Layout -->
<x-shop::layouts>
    <!-- Page Title -->
    <x-slot:title>
        Shipping Policy
    </x-slot>

    <div class="container mt-8 max-1180:px-5 max-md:mt-6 max-md:px-4">
        <div class="m-auto w-full max-w-[870px] rounded-xl border border-zinc-200 p-16 px-[90px] max-md:px-8 max-md:py-8 max-sm:border-none max-sm:p-0">
            <h1 class="font-dmserif text-4xl max-md:text-3xl max-sm:text-xl">Shipping Policy</h1>

            <div class="prose mt-6 max-w-none text-zinc-700">
                <p>
                    We aim to process and ship orders promptly. Delivery times and carriers may vary by location.
                </p>
                <ul class="list-disc pl-6">
                    <li>Processing time: 1–3 business days</li>
                    <li>Domestic shipping: 3–7 business days</li>
                    <li>International shipping: Varies by destination</li>
                </ul>
                <p class="mt-4">
                    Update this policy in <code>packages/Webkul/Shop/src/Resources/views/home/shipping-policy.blade.php</code>.
                </p>
            </div>
        </div>
    </div>
</x-shop::layouts>
