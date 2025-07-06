import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                // 'resources/css/app.css',
                'resources/js/app.js',
                'resources/js/vendor.js',
                'resources/js/product.js',
                'resources/js/stock.js',
                'resources/js/category.js',
                'resources/js/invoice.js',
                // 'resources/js/report.js',
                // 'resources/js/role.js',
                // 'resources/js/user.js',
                'resources/js/customer.js',
                'resources/js/dashboard.js',
            ],
            refresh: true,
        }),
        vue(),
    ],
    resolve: {
        alias: {
            'vue': 'vue/dist/vue.esm-bundler.js',
        }
    }
});
