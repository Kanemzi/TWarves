<template>
	<div id="app">
			<header>
				<h1>
					TWarves
				</h1>
			</header>
			<Leaderboard></Leaderboard>
		<Tavern></Tavern>
	</div>
</template>

<script>
import Leaderboard from './components/Leaderboard.vue'
import Tavern from './components/Tavern.vue'

export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
	},
	
	components: {
		Leaderboard, Tavern
	},

	created: function() {
		this.$twitch.onAuthorized((auth) => {
			this.$request.init('http://kanemzi.tk:8080', auth.token)
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
}
</script>

<style>
* {
    margin: 0;
    padding: 0;
    font-family: 'Roboto', sans-serif;
}

body {
    margin: 10px;
    background-color: #391F21;
    /* border: 1px solid #5C2C28; */
}

#app {
    position: relative;
    height: calc(500px - 20px);
}

header {
    width: 100%;
    height: 80px;

    background: url('../assets/banner.png');
    background-size: cover;
    background-position-y: bottom;
}

header h1 {
    margin-top: 10px;
    text-align: center;
    color: white;
    font-size: 2em;
    font-weight: bold;
}
</style>
