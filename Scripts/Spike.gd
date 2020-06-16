extends Node2D


func _ready():
	add_to_group("Spikes")


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D and body.has_method("create_death_cam"):
		body.create_death_cam()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

