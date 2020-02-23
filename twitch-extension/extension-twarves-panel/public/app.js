

Vue.prototype.$twitch = window.Twitch.ext
Vue.prototype.$request = new Request()
Vue.prototype.$userId = ''
Vue.prototype.$eventBus = new Vue()
let vm = new Vue({
		el: '#app',
		created: function() {
			this.$twitch.onAuthorized((auth) => {
				this.$request.init('http://localhost:3000', auth.token)
				this.$userId = auth.userId
				this.$eventBus.$emit('twitch-authorized')
			})
		}
})

