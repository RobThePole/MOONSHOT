extends Control

const TILE_SIZE = 64



onready var map = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = $Enter.position
	
	# Find out if there is a way to call this 
	var rect = $TileMap.get_used_rect()
	var Test = String (rect)
	Test.erase(Test.length() - 1, 1)
	var some_array = Test.split(",", true, 0)
	var Limit_Right = int(some_array[2]) * TILE_SIZE
	var Limit_Bottom = int(some_array[3]) * TILE_SIZE

	$Player/Camera2D.limit_right = Limit_Right
	$Player/Camera2D.limit_bottom = Limit_Bottom
	pass # Replace with function body.


func _on_Exit_body_entered(body):
	if(body.get_name() == "Player"):
		$FadeIn.show()
		$FadeIn.fade_in()
	pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scene/End_Credits.tscn")
	pass # Replace with function body.


func _on_FallZone_body_entered(body):

	# Makes sure to get rid of the Object interesting not the whole Level
	body.queue_free()
	pass # Replace with function body.
