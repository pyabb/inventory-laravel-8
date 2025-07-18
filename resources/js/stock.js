require('./vue-asset');
import CreateStock from "./components/stock/CreateStock.vue";
import ViewStock from "./components/stock/ViewStock.vue";

Vue.component('create-stock', CreateStock);
Vue.component('view-stock', ViewStock);

var app = new Vue({el: '#inventory'});
