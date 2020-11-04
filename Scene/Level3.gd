extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var map = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = $Enter.position
	$Player/Camera2D.limit_bottom = $Exit.position.y
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = $Exit.position.x * 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_body_entered(body):
	if(body.get_name() == "Player"):
		$FadeIn.show()
		$FadeIn.fade_in()
	pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scene/Level3.tscn")
	pass # Replace with function body.
