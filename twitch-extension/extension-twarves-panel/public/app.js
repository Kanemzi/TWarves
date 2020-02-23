

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

			/*
			 * Ecouter les paquets Pubsub provenant de l'EBS
			 *
			 * A chaque message Pubsub reçu, un event 'reveived-[message-type]' est envoyé via l'EventBus.
			 * L'event porte les données reçues
			 */
			 this.$twitch.listen('broadcast', (target, contentType, message) => {
				let m = JSON.parse(message)
				this.$eventBus.$emit('received-' + m.type, m.data)
    	})
		}
})

