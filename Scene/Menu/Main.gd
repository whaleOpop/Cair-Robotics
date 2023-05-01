extends CanvasLayer

var ConstMap = preload("res://Scene/ConstructMap/Contsr.tscn").instantiate()





func _on_onst_map_pressed():
	
	queue_free()
	get_tree().get_root().add_child(ConstMap)

	pass # Replace with function body.
