<template>
	<section id="tavern" :class="{ opened : panelOpened }">
		<div class="tavern-button" @click="onButtonClick">Taverne</div>
		<div class="tavern-panel">
			Rien à voir ici pour le moment !
		</div>
	</section>
</template>

<script>
export default {
	data () {
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
}
</script>

<style scoped>
#tavern {
	position: absolute;
	bottom: 0;
	width: 100%;
	height: 64px;
	
	background-color: #5C2C28;
	overflow: hidden;
	
	transition: all 0.2s;
}

#tavern.opened {
	height: 100%;
}

#tavern .tavern-button {
	position: absolute;
	right: 10px;
	top: 12px;
	width: 110px;
	height: 40px;
	padding-left: 15px;
	line-height: 40px;
	
	vertical-align: middle;
	font-weight: bold;
	font-size: 0.9em;
	cursor: pointer;
	/* outline-style: none; */
	color: white;
	/* border: none; */
	border-radius: 20px;
	background-image: url('../../assets/shop-icon.png');
	background-repeat: no-repeat;
	background-position-x: 75px;
	background-color: #1c121c;
	
	transition: all 0.2s;
}

#tavern .tavern-button:hover {
	transform: scale(1.1, 1.1);
	background-color: #ffc825;
	color: black;
}

.tavern-panel {
	overflow-y: scroll;
	top: 65px;
	height: calc(100% - 60px);
	/* height: 100px; */
	width: calc(100% - 5px);
	position: absolute;

	/* Temporaire */
	color: white;
	text-align: center;
}

.tavern-panel::-webkit-scrollbar
{
	width: 8px;
	background-color: transparent;
}

.tavern-panel::-webkit-scrollbar-thumb
{
	margin-right: 5px;
	border-radius: 10px;
	background-color: #391F21;
}
</style>