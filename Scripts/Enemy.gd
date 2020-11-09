extends KinematicBody2D

const GRAVITY = 600
const ACCERLATION = 4000

export var direction = -1
export var detects_cliffs = true
var motion = Vector2()
var stop = false

signal update_score

# Add in the rayCast to detect Clif


func _ready():
	# Change this based off the default sprite where it is looking
	if(detects_cliffs):
		set_modulate(Color(.5,.3,.5,1))
	
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
		emit_signal("update_score")
		$Timer.start()
		if(body.has_method("bounce")):
			body.bounce()

		
	pass # Replace with function body.
func bounce():
	motion.y = -100

func _on_SideChecker_body_entered(body):
	# Makes sure that you don't hit yourself
	if(body.name == self.name):
		pass
	else:
		if(body.has_method("ouch")):
			body.ouch(self.position.x)
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	pass # Replace with function body.

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
