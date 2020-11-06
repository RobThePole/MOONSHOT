extends KinematicBody2D

const GRAVITY = 300
const ACCERLATION = 1500

export var direction = -1
export var detects_cliffs = true
var motion = Vector2()
var stop = false

# Add in the rayCast to detect Clif


func _ready():
	# Change this based off the default sprite where it is looking
	if direction==-1:
		$Sprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorChecker.enabled = detects_cliffs

	pass

func _physics_process(delta):
	
	

	if is_on_wall() or not $FloorChecker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction




	motion.y += GRAVITY * delta
	
	if(direction !=0 and not stop):
		motion.x = direction * ACCERLATION  * delta
	
	
	motion = move_and_slide(motion,Vector2.UP)


func _on_TopChecker_body_entered(body):
	
	if(body.name == self.name):
		pass
	else:
		# Stop player from moving any more
		stop = true
		motion.x = 0
		# Gets rid of all collision layers
		set_collision_layer_bit(4,false)
		set_collision_mask_bit(0,false)
		set_collision_mask_bit(1,false)
		set_collision_mask_bit(4,false)
		
		
		$TopChecker.set_collision_mask_bit(4,false)
		$TopChecker.set_collision_mask_bit(0,false)
		$TopChecker.set_collision_mask_bit(4,false)
		$SideChecker.set_collision_mask_bit(0,false)
		# Starts timer to delete
		$Timer.start()

		
	pass # Replace with function body.


func _on_SideChecker_body_entered(body):
	if(body.name == self.name):
		pass
	else:
		print("ouch")
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	pass # Replace with function body.


func _on_Timer_timeout():
	print("bye")
	queue_free()
	pass # Replace with function body.
