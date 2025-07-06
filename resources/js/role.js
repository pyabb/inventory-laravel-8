import { createApp } from "vue";
import CreateRole from "./components/role/CreateRole.vue";
import ViewRole from "./components/role/ViewRole.vue";

const app = createApp({});

app.component('create-role', CreateRole);
app.component('view-role', ViewRole);
app.mount('#inventory');
