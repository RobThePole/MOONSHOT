extends Control

var scene_path_to_load

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR +"save.dat"


func _ready():
	var button = $OptionsContainer/BackButton
	button.grab_focus()
	# Need to change Options button to have a different scene to load
	button.connect("pressed",self,"on_Button_pressed",[button.scene_to_load])


	load_data()

		
	pass


func on_Button_pressed(scene_to_load):
	save_data()

	
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.

func save_data():
	var data = {
		"sound":$OptionsContainer/Sound.value,
		"music":$OptionsContainer/Music.value
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	# use data in order to not worry about read order
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE,"ROBTHEPOLE")
	if error == OK:
		file.store_var(data)
		file.close()

func load_data():
	# When opening scene load data
	var file = File.new()
	if  file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ,"ROBTHEPOLE")
		if error ==OK:
			var player_data = file.get_var()
			# Replace this with a method to use the data in the correct way
			$OptionsContainer/Sound.value = player_data.sound 
			$OptionsContainer/Music.value = player_data.music 
			file.close()
	

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.


func _on_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),value)
	save_data()
	pass # Replace with function body.


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)
	save_data()


	pass # Replace with function body.
