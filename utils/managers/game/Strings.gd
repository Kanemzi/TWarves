extends Node
# Singleton enregistrant toutes les chaînes de caractères du jeu

class Bot:
	const ERROR_NOT_IN_MINE := "Entrez d'abord dans la mine %s !"
	const ERROR_ALREADY_IN_MINE := "Vous êtes déjà dans la mine %s"
	const ERROR_AUTO_PUNCH := "Vous ne pouvez pas vous frapper vous même %s !"
	const ERROR_TARGET_NOT_IN_MINE := "%s n'est pas actuellement dans la mine %s"
	const ERROR_ALONE_IN_MINE := "Il n'y a personne à frapper %s !"
