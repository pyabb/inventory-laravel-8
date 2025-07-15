import { createApp } from 'vue'
import ReportForm from "./components/report/ReportForm.vue";

const app = createApp({});

app.component('report-form', ReportForm);
app.mount('#inventory');
