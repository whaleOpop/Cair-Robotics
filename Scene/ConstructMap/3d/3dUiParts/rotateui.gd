extends StaticBody3D



func _on_interact():
	if($"../../..".is_visible_in_tree()):
		$"../../..".rotation_degrees.y-=90
		return "rotate"
	
