<template>	
	<section id="leaderboard">
			<table cellspacing="0" v-if="loaded">
					<tr>
							<th>Rang</th>
							<th>Joueur</th>
							<th>Pépites</th>
					</tr>
					<tr v-for="(entry, i) in leaderboard" :key="i">
							<td class="place"><div class="bubble">{{ i + 1 }}</div></td>
							<td class="display-name">{{ entry.display_name }}</td>
							<td class="golden-nuggets">{{ entry.golden_nuggets }}</td>
					</tr>
			</table>
			<div v-else class="loader-container">
				<Loader></Loader>
			</div>
	</section>
</template>

<script>
import Loader from './Loader.vue'

export default {
	data () {
    return {
    	leaderboard: [
        // {display_name: 'TheErnest570_test', golden_nuggets: 125354},
        // {display_name: 'Iskrivv', golden_nuggets: 125235},
        // {display_name: 'EnkyuTV', golden_nuggets: 102215},
        // {display_name: 'Kanemzi', golden_nuggets: 50554},
        // {display_name: 'Iskrivv', golden_nuggets: 50222},
        // {display_name: 'EnkyuTV', golden_nuggets: 10221},
        // {display_name: 'Kanemzi', golden_nuggets: 10001},
        // {display_name: 'Iskrivv', golden_nuggets: 5051},
        // {display_name: 'EnkyuTV', golden_nuggets: 3211},
        // {display_name: 'Kanemzi', golden_nuggets: 3012}
			],
			loaded: false
    }
	},
	
	mounted() {
			this.$eventBus.$on('twitch-authorized', this.onAuthorized)
			this.$eventBus.$on('received-leaderboard-update', this.onLeaderboardUpdate)
	},
	
	methods: {
		onAuthorized: function() {
			this.$request.get('/refresh-leaderboard')
			.then( leaderboard => {
				setTimeout( () => {
					this.leaderboard = leaderboard
					this.loaded = true
				}, 2000) // délai artificiel pour l'affichage du loader
			})
		},
	
		onLeaderboardUpdate: function(leaderboard) {
			this.leaderboard = leaderboard
		}
	},

	components: {
		Loader
	}
}
</script>

<style scoped>
#leaderboard table {
    width: 100%;
		color: white;
		table-layout: fixed;
}

#leaderboard table th {
    text-align: left;
    color: lightgray;
    font-size: 0.7em;
    text-transform: uppercase;
		height: 24px;
		font-weight: lighter;
}

#leaderboard table td {
		height: 30px;
		font-size: 0.9em;
}

#leaderboard table td.place .bubble {
		margin: auto;
		text-align: center;
		height: 24px;
		width: 24px;
		background-color: #5C2C28;
		border-radius: 12px;
		line-height: 26px;
		vertical-align: center;
		animation: glowing-dark 5000ms infinite;
}

#leaderboard table tr:nth-child(2) .bubble {
	background-color: #ffa214;
	animation: glowing-gold 5000ms infinite;
}

#leaderboard table tr:nth-child(3) .bubble {
	background-color: #657392;
	animation: glowing-silver 5000ms infinite;
	animation-delay: 0.3s;
}

#leaderboard table tr:nth-child(4) .bubble {
	background-color: #8e251d;
	animation: glowing-bronze 5000ms infinite;
	animation-delay: 0.6s;
}

#leaderboard table td.display-name {
		font-weight: normal;
		padding-left: 10px;
		transition: transform 0.1s;
}

#leaderboard table td.golden-nuggets {
	text-align: right;
	padding-right: 40px;
	background-image: url('../assets/shop-icon.png');
	background-repeat: no-repeat;
	background-size: 30px;
	background-position-x: 95%;
	font-weight: lighter;
}

#leaderboard table th:first-of-type {
		text-align: center;
		width: 15%;
}

#leaderboard table th:nth-child(2) {
	padding-left: 10px;
	width:  40%;
}

#leaderboard table th:last-of-type {
    text-align: right;
		padding-right: 10px;
		width: 45%;
}

/* Effects */
#leaderboard table tr {
    transition: background-color 0.1s;
}

#leaderboard table tr:hover:not(:first-of-type) {
		background-color: #5C2C28;
    cursor: pointer;
}

#leaderboard table tr:hover .display-name {
	transform: scale(1.2);
}

#leaderboard .loader-container {
	padding-top: 50%;
}



@keyframes glowing-gold {
  0% { box-shadow: 0 0 10px #ffbc56; }
	50% { box-shadow: 0 0 30px #ffbc56; }
	100% { box-shadow: 0 0 10px #ffbc56; }
}

@keyframes glowing-silver {
  0% { box-shadow: 0 0 10px #c2c2c2; }
  50% { box-shadow: 0 0 20px #c2c2c2; }
  100% { box-shadow: 0 0 10px #c2c2c2; }
}

@keyframes glowing-bronze {
  0% { box-shadow: 0 0 10px #ff7268; }
  50% { box-shadow: 0 0 20px #ff7268; }
  100% { box-shadow: 0 0 10px #ff7268; }
}

@keyframes glowing-dark {
  0% { box-shadow: 0 0 5px #391F21; }
  50% { box-shadow: 0 0 10px #391F21; }
  100% { box-shadow: 0 0 5px #391F21; }
}
</style>