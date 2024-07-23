extends CSGCylinder3D

func _get_color():
	var mat = get("material_override")
	return mat.get("albedo_color")
	
