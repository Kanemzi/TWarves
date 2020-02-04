extends Node2D
# Permet de gérer les instances d'items dans la cave

export(PackedScene) var GoldenNuggetScene : PackedScene

func _ready():
	pass


# Fait apparaître un certain nombre de pépites d'or à un endroit de la mine
func spawn_golden_nuggets(pos: Vector2, amount: int, direction := Vector2.ZERO) -> void:
	for i in amount:
		var nugget := GoldenNuggetScene.instance() as GoldenNugget
		print(direction)
		nugget.init(direction)
		nugget.translate(pos)
		add_child(nugget)
