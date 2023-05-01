extends StaticBody3D


func _ready():
	pass


func _on_input_event(camera, event, position, normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == MOUSE_BUTTON_LEFT and mouse_click.is_pressed():
		print("clicked")
