extends KinematicBody2D

const GRAVITY = 300
const ACCERLATION = 1500

export var direction = -1
export var detects_cliffs = true
var motion = Vector2()

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
	
	if(direction !=0):
		motion.x = direction * ACCERLATION  * delta
	
	
	motion = move_and_slide(motion,Vector2.UP)
