extends Node2D
var selected = false 


func _process(delta):
	if selected:
		folowMouse()
	pass

func folowMouse():
	position = get_global_mouse_position()
	
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			selected= true
		else:
			selected=false
	pass # Replace with function body.
