let mix = require("laravel-mix");

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.options({
    terser: {
        extractComments: false,
    }
});

mix.js("resources/js/app.js", "public/js");
mix.js("resources/js/vendor.js", "public/js");
mix.js("resources/js/product.js", "public/js");
mix.js("resources/js/stock.js", "public/js");
mix.js("resources/js/category.js", "public/js");
mix.js("resources/js/invoice.js", "public/js");
mix.js("resources/js/report.js", "public/js");
mix.js("resources/js/role.js", "public/js");
mix.js("resources/js/user.js", "public/js");
mix.js("resources/js/customer.js", "public/js");
mix.js("resources/js/dashboard.js", "public/js");
//mix.sass("resources/sass/app.scss", "public/css");
