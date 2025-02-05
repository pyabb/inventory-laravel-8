require('./vue-asset');
import CreateProduct from "./components/product/CreateProduct.vue";
import ViewProduct from "./components/product/ViewProduct.vue";

Vue.component('create-product', CreateProduct);
Vue.component('view-product', ViewProduct);

var app = new Vue({el: '#inventory'});
