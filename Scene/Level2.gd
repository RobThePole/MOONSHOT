extends Control



func _ready():
	$Player.position = $Enter.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scene/Level3.tscn")
	pass # Replace with function body.

func _on_Exit_body_entered(body):
	if(body.get_name() == "Player"):
		$FadeIn.show()
		$FadeIn.fade_in()
	pass # Replace with function body.
