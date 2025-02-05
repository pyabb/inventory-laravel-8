require('./vue-asset');
import CreateVendor from "./components/vendor/CreateVendor.vue";
import ViewVendor from "./components/vendor/ViewVendor.vue";

Vue.component('create-vendor', CreateVendor);
Vue.component('view-vendor', ViewVendor);

var app = new Vue({el: '#inventory'});
