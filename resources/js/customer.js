require('./vue-asset');
import CreateCustomer from "./components/customer/CreateCustomer.vue";
import ViewCustomer from "./components/customer/ViewCustomer.vue";

Vue.component('create-customer', CreateCustomer);
Vue.component('view-customer', ViewCustomer);

var app = new Vue({el: '#inventory'});
