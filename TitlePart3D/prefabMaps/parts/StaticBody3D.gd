extends StaticBody3D

signal cell_pressed(value:bool) 
signal obj_link(link) 

func _on_interact():
	obj_link.emit($"../..")
	if(get("metadata/isSelected")):
		set("metadata/isSelected",false)
		cell_pressed.emit(get("metadata/isSelected"))
	else:
		set("metadata/isSelected",true)
		cell_pressed.emit(get("metadata/isSelected"))
	return "cell"

	


