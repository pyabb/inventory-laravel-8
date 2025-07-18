import { createApp } from 'vue';
import CreateVendor from "./components/vendor/CreateVendor.vue";
import ViewVendor from "./components/vendor/ViewVendor.vue";

const app = createApp({});

app.component('create-vendor', CreateVendor);
app.component('view-vendor', ViewVendor);
app.mount('#inventory');
