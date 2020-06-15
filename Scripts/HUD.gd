extends Control


func _ready():
	add_to_group("HUD")
	$RestartLabel.visible = false


func show_restart_label():
	$RestartLabel.visible = true

