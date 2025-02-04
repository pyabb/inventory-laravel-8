require('./vue-asset');
import CreateUser from "./components/user/CreateUser.vue";
import ViewUser from "./components/user/ViewUser.vue";

Vue.component('create-user', CreateUser);
Vue.component('view-user', ViewUser);

var app = new Vue({el: '#inventory'});
