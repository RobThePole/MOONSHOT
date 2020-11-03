extends KinematicBody2D


const ACCERLATION = 500
const MAX_SPEED = 64
const FRIGTION = 0.25
const GRAVITY = 300
const JUMP_FORCE = 200
const AIR_RESISTANCE = 0.02
const SPRINT = 2
# Add const for MAX_SPEED_SPRINT ?
# Add camera system to game
# Add in tile_set for game
# Add in player_sprite for game
# Add in enemy_sprite for game

onready var sprite = $Sprite
# Collision works need to add tiles to the game to build 

var motion = Vector2()


func _physics_process(delta):

	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var sprint_input = Input.get_action_strength("ui_shift")
	

	# Movement left and right with sprint included
	if(x_input !=0):
		motion.x += x_input * ACCERLATION  * delta
		motion.x = clamp(motion.x,-MAX_SPEED ,MAX_SPEED)
		sprite.flip_h = x_input < 0
		if(sprint_input):
			motion.x += x_input * ACCERLATION * SPRINT * delta
			motion.x = clamp(motion.x,-MAX_SPEED * SPRINT, MAX_SPEED * SPRINT)

		
	# Gravity	
	motion.y += GRAVITY * delta
	
	# Jumping and floor detection
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x,0,FRIGTION)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE	
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		if x_input == 0:
			motion.x = lerp(motion.x,0,AIR_RESISTANCE)


	motion = move_and_slide(motion,Vector2.UP)

# Need to add Shoot Feature
# Need to add dodge Feature
# Need to add MoonShot Feature
