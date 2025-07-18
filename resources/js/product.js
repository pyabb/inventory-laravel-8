import { createApp } from "vue";
import CreateProduct from "./components/product/CreateProduct.vue";
import ViewProduct from "./components/product/ViewProduct.vue";

const app = createApp({});

app.component('create-product', CreateProduct);
app.component('view-product', ViewProduct);
app.mount('#inventory');
