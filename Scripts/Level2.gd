extends Control


const TILE_SIZE = 64
var next_level

var Enemies

func _ready():
	$Player.position = $Enter.position
	# Gets TileMap Width and Height
	var rect = $TileMap.get_used_rect()
	var Test = String (rect)
	Test.erase(Test.length() - 1, 1)
	var some_array = Test.split(",", true, 0)
	var Limit_Right = int(some_array[2]) * TILE_SIZE
	var Limit_Bottom = int(some_array[3]) * TILE_SIZE
	

	$Player/Camera2D.limit_right = Limit_Right
	$Player/Camera2D.limit_bottom = Limit_Bottom
	
	Enemies = $Enemies.get_child_count()

	$Exit.connect("body_entered",self,"on_change_level",[$Exit.scene_to_load])

func on_change_level(body,scene_to_load):
	if(body.get_name() == "Player" and Enemies == 0):
		next_level = scene_to_load
		$FadeIn.show()
		$FadeIn.fade_in()
	


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene(next_level)
	pass # Replace with function body.


func _on_Exit_body_entered(body):
	if Enemies == 0:
		$FadeIn.show()
		$FadeIn.fade_in()
	pass # Replace with function body.


func _on_FallZone_body_entered(body):
	if(body.name == "Player" and Enemies != 0):
		get_tree().change_scene("res://Scene/Levels/Level2Restart.tscn")
	elif(body.name != "Player"):
		body.queue_free()
	pass # Replace with function body.



func _on_Enemy_update_score():
	Enemies -= 1
	pass # Replace with function body.
