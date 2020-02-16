class_name TDLMessageBuilder
# Classe permettant de générer les différents messages gérés par le 
# protocole TDL

# Crée un message de type REQUEST_PLAYER
static func create_request_player(user_id: String, display_name: String) -> TDLMessage:
	return TDLMessage.new(TDLMessage.Type.REQUEST_PLAYER, {
		user_id = user_id,
		display_name = display_name
	})


# Crée un message de type SAVE_PLAYER_DATA
static func create_save_player_data(user_id: String, golden_nuggets: int) -> TDLMessage:
	return TDLMessage.new(TDLMessage.Type.SAVE_PLAYER_DATA, {
		user_id = user_id,
		golden_nuggets = golden_nuggets
	})
