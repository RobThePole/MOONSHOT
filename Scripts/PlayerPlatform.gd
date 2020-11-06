extends KinematicBody2D


const ACCERLATION = 500
const MAX_SPEED = 64
const FRIGTION = 0.25
const GRAVITY = 300
const JUMP_FORCE = 200
const AIR_RESISTANCE = 0.02
const SPRINT = 20
# Add const for MAX_SPEED_SPRINT ?


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

func bounce():
	motion.y = -JUMP_FORCE * .7
func ouch(var enemyPosx):
	set_modulate(Color(1,0.3,0.3,0.3))
	motion.y = -JUMP_FORCE * .4
	
	
	if position.x < enemyPosx:

		motion.x = -100
	elif position.x > enemyPosx:
		motion.x = 100
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
	set_collision_layer_bit(0,false)
	
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(1,false)
	set_collision_mask_bit(4,false)
	
	# Keep this as Current if we change to Game_over Screen
	$Camera2D.current = false
	$Timer.start()


func _on_Timer_timeout():
	
	#Replace this with Gamer_Over screen instead
	queue_free()
	
	pass # Replace with function body.
