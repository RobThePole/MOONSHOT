extends CenterContainer



# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Go in and make some kind of background drop for the game
	$BackGround.rect_min_size.x = get_viewport().size.x
	$BackGround.rect_min_size.y = get_viewport().size.y
	print($BackGround.rect_min_size)


	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_TextureButton_button_down():
	get_tree().change_scene("res://Scene/Level1.tscn")
	pass # Replace with function body.
