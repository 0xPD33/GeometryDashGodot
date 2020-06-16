extends Control


func _ready():
	add_to_group("HUD")
	
	# hide both the restart and won label on game start
	$RestartLabel.visible = false
	$WonLabel.visible = false
	
	$HBoxContainer/DeathCounter.text = "Deaths: " + str(Global.deaths)
	
	# only show the controls once
	if not Global.controls_shown:
		$AnimationPlayer.play("fade")
	
	Global.controls_shown = true


func update_deaths():
	Global.deaths += 1
	$HBoxContainer/DeathCounter.text = "Deaths: " + str(Global.deaths)


func show_restart_label():
	$RestartLabel.visible = true


func show_winning_label():
	$WonLabel.visible = true


func fade_to_black():
	$AnimationPlayer.play("black_screen")
	yield($AnimationPlayer, "animation_finished")
	get_tree().call_group("Game", "quit_game")

