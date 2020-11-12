extends KinematicBody2D


const ACCERLATION = 1000
const MAX_SPEED = 128
const FRIGTION = 0.25
const GRAVITY = 600
const JUMP_FORCE = 600
const AIR_RESISTANCE = 0.02
const SPRINT = 5
export (String) var currentLevel
# Stop can be used for both player death and cut_scenes
var stop = false

const STATE = {walk = "Walk",sprint = "Sprint",idle = "Idle",jump = "Jump",fall = "Fall"}
var state = STATE.idle
# Go in and add in animated character in order to get better understanding of movement


onready var sprite = $Sprite
# Collision works need to add tiles to the game to build 

var motion = Vector2()


func _physics_process(delta):

	if Input.is_action_just_pressed("restart"):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(currentLevel)

	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var sprint_input = Input.get_action_strength("ui_shift")
	

	# Movement left and right with sprint included
	if(x_input !=0 and not stop):
		# Makes sure to set walking animation only when on floor
		if is_on_floor():
			state = STATE.walk
		motion.x += x_input * ACCERLATION  * delta
		motion.x = clamp(motion.x,-MAX_SPEED ,MAX_SPEED)
		sprite.flip_h = x_input < 0
		if(sprint_input):
			#state = STATE.sprint
			motion.x += x_input * ACCERLATION * SPRINT * delta
			motion.x = clamp(motion.x,-MAX_SPEED * SPRINT, MAX_SPEED * SPRINT)

		
	# Gravity
	motion.y += GRAVITY * delta
	
	# Animation state of the character when not moving
	if is_on_floor() and x_input == 0:
		state = STATE.idle
		print(state)

	
	# Jumping and floor detection
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x,0,FRIGTION)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			$Jump.play()
			
			#state = STATE.jump	
	else:
		# is in air
		if(motion.y > 0):
			#state = STATE.fall
			pass
		# warning-ignore:integer_division
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
		# warning-ignore:integer_division
			motion.y = -JUMP_FORCE/2
		if x_input == 0:
			motion.x = lerp(motion.x,0,AIR_RESISTANCE)
			
			
	# Used to test animation state works
	if(state == null):
		$AnimationPlayer.stop(true)
	else:
		$AnimationPlayer.play(state)
		
	motion = move_and_slide(motion,Vector2.UP)

func bounce():
	motion.y = -JUMP_FORCE * .7
	$Bounce.play()
func ouch(var enemyPosx):
	set_modulate(Color(1,0.3,0.3,0.3))
	motion.y = -JUMP_FORCE * .4
	$Die.play()
	#stop makes it so player can not move while dying
	stop = true
	if position.x < enemyPosx:

		motion.x = -100
	elif position.x > enemyPosx:
		motion.x = 100

	set_collision_layer_bit(0,false)
	
	
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(1,false)
	set_collision_mask_bit(4,false)
	
	# Keep this as Current if we change to Game_over Screen
	$Camera2D.current = false
	$Timer.start()


func _on_Timer_timeout():
	#Replace this with Gamer_Over screen instead
	stop = false
# warning-ignore:return_value_discarded
	get_tree().change_scene(currentLevel)
	#queue_free()
	
	pass # Replace with function body.
