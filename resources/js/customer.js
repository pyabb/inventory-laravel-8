import { createApp } from "vue";
import CreateCustomer from "./components/customer/CreateCustomer.vue";
import ViewCustomer from "./components/customer/ViewCustomer.vue";

const app = createApp({});

app.component('create-customer', CreateCustomer);
app.component('view-customer', ViewCustomer);
app.mount('#inventory');
