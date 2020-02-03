extends DwarfState
class_name DwarfPunchState
# Etat dans lequel le nain attaque un autre nain dans la mine

# TODO :
# - En entrant dans cet état, le nain trouve la référence vers le nain à cibler
# - Si le nom est incorrect, le nain le plus proche?/riche? est attaqué
# - Le nain attend la disparition de son icone d'action pour commencer à attaquer
# - Le nain commence à se déplacer vers sa cible.
# 	- Particules de poussière
#	- Icone de "Warning" clignote au dessus de la cible
#		- Shader de glow pour l'icone
# - Une fois assez proche de la cible, le nain s'arrête et frappe
#	- (Area2D de proximité pour la détection de la cible)
#	- Apparition d'une hitbox de coup 
#	- Si la cible entre en contact avec la hitbox, il entre en état de stun
#	- Si la cible entre en contact avec la hitbox, elle droppe des pépites
# - Pour attaquer, le nain se déplace au max jusqu'à la cible + une distance définie
# 	- Si la distance max est atteinte le nain entre en état de fatigue et arrête d'attaquer

# Points bonus :
# - Si deux nains s'attaquent entre eux, il devraient tous les deux être stun
# - En frappant le nain, les pépites sont droppées en respectant le sens du coup
# - Système de force définissant la durée du stun de la cible et la quantité de pépites droppées

func _ready() -> void:
	pass
