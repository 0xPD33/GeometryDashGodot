extends KinematicBody2D

const WORLD_LIMIT = 1500

# export variables for the player logic. tinkering with these values could possibly break the game
# and would require rearranging most spikes in the level.
export var move_speed = 400
export var jump_height = -800
export var gravity = 2500

var velocity = Vector2()

onready var JumpAnim = $JumpAnimation


func _ready():
	# adds the player to a group so the methods in this script can be easily called from elsewhere.
	add_to_group("Player")


func _process(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_height
			
			# checks if the animation is playing or not. if it is: stop and play it again.
			# fixes a bug that prevents the jump anim to play when performing multiple jumps in quick succession
			if not JumpAnim.is_playing():
				JumpAnim.play("jump_anim")
			elif JumpAnim.is_playing():
				JumpAnim.stop()
				JumpAnim.play("jump_anim")
	
	# if the position of the player is equal to or lower than the world limit: kill the player
	if position.y >= WORLD_LIMIT:
		player_death()


# starts moving the player right
func move_player():
	velocity.x += 1
	velocity = velocity.normalized() * move_speed


func player_death():
	queue_free()

