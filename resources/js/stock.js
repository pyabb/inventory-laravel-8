import { createApp } from "vue";
import CreateStock from "./components/stock/CreateStock.vue";
import ViewStock from "./components/stock/ViewStock.vue";

const app = createApp({});
app.component('create-stock', CreateStock);
app.component('view-stock', ViewStock);
app.mount('#inventory');
