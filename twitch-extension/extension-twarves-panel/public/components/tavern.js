Vue.component('tavern', {
	template: `
<section id="tavern" :class="{ opened : panelOpened }">
	<div class="tavern-button" @click="onButtonClick">Taverne</div>
	<div class="tavern-panel">
		Rien à voir ici pour le moment !
	</div>
</section>
	`,
	data: () => {
			return {
				panelOpened: false
			}
	},
	methods: {
		onButtonClick: function (ev) {
			this.panelOpened = !this.panelOpened
			console.log('clicked')
		}
	}
})