extends Panel




func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Panel_gui_input(event:InputEvent)->void:
	if event is InputEventScreenDrag:
		rect_position+=event.relative
	pass # Replace with function body.


func _on_Okey_pressed():

	return true # Replace with function body.


func _on_Cancel_pressed():
	
	return false # Replace with function body.
