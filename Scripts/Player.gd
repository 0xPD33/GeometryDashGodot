extends KinematicBody2D

const WORLD_LIMIT = 1500

# export variables for the player logic. tinkering with these values could possibly break the game
# and would require rearranging most spikes in the level.
export var move_speed = 400
export var jump_height = -800
export var gravity = 2500

var velocity = Vector2()
var dead = false


func _ready():
	# adds the player to a group so the methods in this script can be easily called from elsewhere
	add_to_group("Player")


func _process(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_height
			
			# checks if the animation is playing or not. if it is: stop and play it again.
			# fixes a bug that prevents the jump anim to play when performing multiple jumps in quick succession.
			if not $JumpAnimation.is_playing():
				$JumpAnimation.play("jump_anim")
			elif $JumpAnimation.is_playing():
				$JumpAnimation.stop()
				$JumpAnimation.play("jump_anim")
	
	# if the position of the player is equal to or lower than the world limit: kill the player
	if position.y >= WORLD_LIMIT:
		create_death_cam()


# starts moving the player right
func move_player():
	velocity.x += 1
	velocity = velocity.normalized() * move_speed


# completely locks the player in place
func lock_movement():
	velocity = Vector2(0, 0)
	move_speed = 0
	jump_height = 0
	gravity = 0


func player_death():
	# only run this code if the player is not dead and set dead to true afterwards. 
	# not doing this check results in the function being run multiple times, which
	# later results in multiple deaths being counted and other problems.
	if not dead:
		dead = true
		lock_movement()
		$DeathAnimation.play("death_anim")
		yield($DeathAnimation, "animation_finished")
		queue_free()
		call_hud()


func call_hud():
	get_tree().call_group("HUD", "update_deaths")
	get_tree().call_group("HUD", "show_restart_label")


# creates a new camera, which stays in the position where you died
func create_death_cam():
	# get camera position from the player camera 
	var player_cam_pos = $Camera2D.get_camera_position()
	
	# create the new camera
	var death_cam = Camera2D.new()
	death_cam.position = player_cam_pos
	death_cam.zoom = Vector2(0.9, 0.9)
	
	# add the camera as a child of the level
	get_parent().add_child(death_cam)
	death_cam.current = true
	
	player_death()

