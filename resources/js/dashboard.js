require('./vue-asset');
import InfoBox from './components/dashboard/InfoBox.vue';

Vue.component('info-box', InfoBox);

var app = new Vue({el: '#inventory'});
