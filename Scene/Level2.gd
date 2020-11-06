extends Control


const TILE_SIZE = 16


func _ready():
	$Player.position = $Enter.position
	# Gets TileMap Width and Height
	var rect = $TileMap.get_used_rect()
	var Test = String (rect)
	Test.erase(Test.length() - 1, 1)
	var some_array = Test.split(",", true, 0)
	var Limit_Right = int(some_array[2]) * TILE_SIZE
	var Limit_Bottom = int(some_array[3]) * TILE_SIZE
	
	# Does this still work?
	$Player/Camera2D.limit_right = Limit_Right
	$Player/Camera2D.limit_bottom = Limit_Bottom


	pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scene/Level3.tscn")
	pass # Replace with function body.


func _on_Exit_body_entered(body):
	#if(body.get_name() == "Player"):
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.



func _on_FallZone_body_entered(body):
	if(body.name == "Player"):
		$Player/Camera2D.current = false
	# Makes sure to get rid of the Object interesting not the whole Level
	body.queue_free()
	pass # Replace with function body.
