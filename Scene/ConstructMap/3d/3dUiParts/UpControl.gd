extends StaticBody3D


func _on_interact():
	if($"../..".is_visible_in_tree()):
		return "up"
