Vue.component('leaderboard', {
    template: `
<section id="leaderboard">
    <table cellspacing="0" v-if="loaded">
        <tr>
            <th>Rang</th>
            <th>Joueur</th>
            <th>Pépites</th>
        </tr>
        <tr v-for="(entry, i) in leaderboard">
            <td class="place"><div class="bubble">{{ i + 1 }}</div></td>
            <td class="display-name">{{ entry.display_name }}</td>
            <td class="golden-nuggets">{{ entry.golden_nuggets }}</td>
				</tr>
		</table>
		<div v-else class="loader-container">
			<loader></loader>
		</div>
</section>
    `,
    data: () => {
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
		
		mounted: function() {
				this.$eventBus.$on('twitch-authorized', this.onAuthorized)
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
				}
		}
})