require('./vue-asset');
import CreateRole from "./components/role/CreateRole.vue";
import ViewRole from "./components/role/ViewRole.vue";

Vue.component('create-role', CreateRole);
Vue.component('view-role', ViewRole);

var app = new Vue({el: '#inventory'});
