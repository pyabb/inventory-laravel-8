require('./vue-asset');
import CreateInvoice from "./components/invoice/CreateInvoice.vue";
import ViewInvoice from "./components/invoice/ViewInvoice.vue";

Vue.component('create-invoice', CreateInvoice);
Vue.component('view-invoice', ViewInvoice);

var app = new Vue({el: '#inventory'});
