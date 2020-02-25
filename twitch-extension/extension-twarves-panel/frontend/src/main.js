import Vue from 'vue'
import App from './App.vue'
import Request from './request'

Vue.prototype.$twitch = window.Twitch.ext
Vue.prototype.$request = new Request()
Vue.prototype.$userId = ''
Vue.prototype.$eventBus = new Vue()

new Vue({
  el: '#app',
  render: h => h(App)
})
