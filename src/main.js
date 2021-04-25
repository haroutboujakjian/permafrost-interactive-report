import Vue from 'vue'
import App from './App.vue'
import 'bulma/css/bulma.min.css'
import '@/styles/styles.css'
import VueSlider from "vue-slider-component";
import 'vue-slider-component/theme/default.css'
import {library} from "@fortawesome/fontawesome-svg-core";
import {faMousePointer, faCloud} from "@fortawesome/free-solid-svg-icons";
import {FontAwesomeIcon} from "@fortawesome/vue-fontawesome";

library.add(faMousePointer, faCloud)

Vue.component('VueSlider', VueSlider)
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.config.productionTip = false

new Vue({
	render: h => h(App),
}).$mount('#app')
