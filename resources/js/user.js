import { createApp } from "vue";
import CreateUser from "./components/user/CreateUser.vue";
import ViewUser from "./components/user/ViewUser.vue";

const app = createApp({});

app.component('create-user', CreateUser);
app.component('view-user', ViewUser);
app.mount('#inventory');
