extends DwarfState

func enter(params: Dictionary = {}) -> void:
	return
	dwarf.animator.play("idle")
	print("queued : " + dwarf.display_name)
	# TEMP
	var time := randf()
	dwarf.animator.advance(time)
	return

func exit() -> void:
	return

func update(delta: float) -> void:
	return

func _on_queue_advanced(dwarf : Dwarf) -> void :
	print("queue advance : " + str(dwarf.player_name))
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
