extends Control

var scene_path_to_load


const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR +"save.dat"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/StartGame.grab_focus()
	# Need to change Options button to have a different scene to load
	load_data()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed",self,"on_Button_pressed",[button.scene_to_load])
	pass # Replace with function body.


func load_data():
	# When opening scene load data
	var file = File.new()
	if  file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ,"ROBTHEPOLE")
		if error ==OK:
			var player_data = file.get_var()
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),player_data.sound )
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),player_data.music)
			# Replace this with a method to use the data in the correct way

			file.close()
	


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
