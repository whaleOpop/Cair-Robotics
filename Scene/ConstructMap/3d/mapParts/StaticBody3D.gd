extends CSGBox3D

signal cell_pressed(value:bool) 
signal obj_link(link) 

func _on_interact():
	obj_link.emit($"..")
	if($"..".get("metadata/isSelected")):
		cell_pressed.emit($"..".get("metadata/isSelected"))
		$"..".set("metadata/isSelected",false)
	else:
		cell_pressed.emit($"..".get("metadata/isSelected"))
		$"..".set("metadata/isSelected",true)
	return "cell"

func _get_color():
	var mat = get("material_override")
	return mat.get("albedo_color")
