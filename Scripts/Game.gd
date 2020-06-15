extends Node2D


func _ready():
	# waits for one frame so all nodes can run their _ready function.
	yield(get_tree(), "idle_frame")
	# calls the method "move_player" from the "Player" group.
	get_tree().call_group("Player", "move_player")


func _process(delta):
	_get_input()


func _get_input():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

