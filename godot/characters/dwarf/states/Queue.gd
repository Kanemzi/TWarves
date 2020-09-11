extends DwarfState
class_name DwarfQueueState
# Etat dans lequel le nain attend dans la queue et avance si possible

var queue: DwarfQueue
var queue_index: int

func physics_process(delta: float) -> void:
	_parent.move_to_target(delta)


func enter(params := {}) -> void:
	if not "queue" in params and not "index" in params:
		return
	
	queue = params.queue as DwarfQueue
	queue_index = params.index
	queue.connect("advanced", self, "_on_DwarfQueue_advanced")
	_parent.connect("target_reached", self, 
			"_on_Dwarf_target_reached", [], CONNECT_DEFERRED)

	var place := _get_queue_position()
	_parent.target(place)
	dwarf.animator.play("run")
	dwarf.can_action = false


func exit() -> void:
	queue.disconnect("advanced", self, "_on_DwarfQueue_advanced")
	_parent.disconnect("target_reached", self, "_on_Dwarf_target_reached")
	dwarf.can_action = true
	# On compte le temps passé de la mine seulement une fois sorti de la file d'attente
	dwarf.exit_timer.start()


# S'exécute lorsque le nain a atteint le filon qu'il doit exploiter
func _on_Dwarf_target_reached() -> void:
	if queue_index == 0 && queue.current_in_mine < queue.max_allowed_in_mine:
		_exit_mine()
	else:
		dwarf.animator.play("idle")


# Exécutée lorsque la file des nains avance
func _on_DwarfQueue_advanced() -> void:	
	if queue_index != 0:
		queue_index -= 1
	if queue_index < queue.places.size():
		var place := _get_queue_position()
		_parent.target(place)
		dwarf.animator.play("run")


# Retourne la position que doit avoir le nain dans la file en 
# fonction de son index de file
func _get_queue_position() -> Vector2:
	var index := min(queue_index, queue.places.size() - 1)
	return (queue.places[index] as Position2D).position 


# Quitte la queue et change d'état
func _exit_mine() -> void:
	dwarf.state_machine.transition_to("Move/Dig")
	dwarf.emit_signal("queue_exited")
