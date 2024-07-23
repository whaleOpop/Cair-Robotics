extends StaticBody3D


func _on_interact():
	if($"../..".is_visible_in_tree()):
		print("work")
		return "delete"
	
