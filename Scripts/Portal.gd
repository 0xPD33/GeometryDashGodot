extends Node2D


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		body.queue_free()
		zoom_cam()


func zoom_cam():
	$Camera2D.current = true
	$Camera2D/CameraZoom.play("cam_zoom")
	yield($Camera2D/CameraZoom, "animation_finished")
	start_fade_to_black()


func start_fade_to_black():
	get_tree().call_group("HUD", "fade_to_black")


func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("portal_anim")

