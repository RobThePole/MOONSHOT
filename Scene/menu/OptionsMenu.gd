extends Control

var scene_path_to_load



func _ready():
	var button = $OptionsContainer/BackButton
	button.grab_focus()
	# Need to change Options button to have a different scene to load
	button.connect("pressed",self,"on_Button_pressed",[button.scene_to_load])

		
	pass


func on_Button_pressed(scene_to_load):
	print("test")
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.
