extends Control

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/StartGame.grab_focus()
	# Need to change Options button to have a different scene to load
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed",self,"on_Button_pressed",[button.scene_to_load])
	pass # Replace with function body.

func on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_FadeIn_fade_finished():
	if(scene_path_to_load == "EXIT"):
		get_tree().quit()
	else:
		get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.
