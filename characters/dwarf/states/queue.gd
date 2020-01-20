extends State

func _enter(parameters: Dictionary = {}) -> void:
	owner.animator.play("idle")
	print("queued : " + owner.player_name)
	# TEMP
	var time := randf()
	owner.animator.advance(time)
	return

func _exit() -> void:
	return

func _update(delta: float) -> void:
	return

func _on_queue_advanced(dwarf) -> void :
	print("queue advance : " + dwarf.player_name)
	return
	if self == dwarf :
		emit_signal("finished", "idle", {})
		return
	var i = owner.get_index()
	if i > 4 : i = 4
	#var place = queue.get_node("Places").get_child(i)
	#owner.move_to_point(place.position)

func _on_animation_finished(animation_name: String) -> void:
	return
