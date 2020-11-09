extends CanvasLayer

var scene_path_to_load

func _ready():
	var Screen_Size = Vector2(OS.get_window_size())
	var Width = Screen_Size.x / 4
	var Height = Screen_Size.y /4 
	offset.x = Width
	offset.y = Height
	var button = $Pause/BackButton
	button.connect("pressed",self,"on_Button_pressed",[button.scene_to_load])

func _input(event):
	if(event.is_action_pressed("pause")):
		get_tree().paused = not get_tree().paused
		$Pause.visible = get_tree().paused
		
func on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	
	


func _on_FadeIn_fade_finished():
	get_tree().paused = false
	get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.
