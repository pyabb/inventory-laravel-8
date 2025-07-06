import { createApp } from 'vue';
import CreateInvoice from "./components/invoice/CreateInvoice.vue";
import ViewInvoice from "./components/invoice/ViewInvoice.vue";

const app = createApp({});

app.component('create-invoice', CreateInvoice);
app.component('view-invoice', ViewInvoice);
app.mount('#inventory');
