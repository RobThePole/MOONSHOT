extends CanvasLayer

func _ready():
	var Screen_Size = Vector2(OS.get_window_size())
	var Width = Screen_Size.x / 8
	var Height = Screen_Size.y /8 


	offset.x = Width
	offset.y = Height
	pass
