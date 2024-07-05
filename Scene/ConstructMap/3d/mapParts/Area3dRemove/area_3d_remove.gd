extends Node3D



func _on_area_3d_body_entered(body):
	print(body)
	body.get_parent().queue_free()
	pass # Replace with function body.
