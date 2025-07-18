import { createApp } from 'vue';
import CreateCategory from "./components/category/CreateCategory.vue";
import ViewCategory from "./components/category/ViewCategory.vue";

const app = createApp({});

app.component('create-category', CreateCategory);
app.component('view-category', ViewCategory);
app.mount('#inventory');
