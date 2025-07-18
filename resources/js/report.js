require('./vue-asset');
import ReportForm from "./components/report/ReportForm.vue";

Vue.component('report-form', ReportForm);

var app = new Vue({el: '#inventory'});
