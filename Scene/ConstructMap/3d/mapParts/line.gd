extends StaticBody3D

func _get_color():
	var mat = $"..".get_surface_override_material(0)
	return mat.get("albedo_color")
	
