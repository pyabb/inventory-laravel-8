require('./vue-asset');
import CreateCategory from "./components/category/CreateCategory.vue";
import ViewCategory from "./components/category/ViewCategory.vue";

Vue.component('create-category', CreateCategory);
Vue.component('view-category', ViewCategory);

var app = new Vue({el: '#inventory'});
