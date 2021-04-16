import Vue from 'vue'
import App from './App.vue'
import 'bulma/css/bulma.min.css'
import VueSlider from "vue-slider-component";
import 'vue-slider-component/theme/default.css'

Vue.component('VueSlider', VueSlider)

Vue.config.productionTip = false

new Vue({
	render: h => h(App),
}).$mount('#app')
