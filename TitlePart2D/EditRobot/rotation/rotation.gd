extends Control

@onready var zMin = $TextureRect/zMin
@onready var yMin = $TextureRect/yMin
@onready var xMin = $TextureRect/xMin
@onready var zMax = $TextureRect/zMax
@onready var yMax = $TextureRect/yMax
@onready var xMax = $TextureRect/xMax

func setRotationByState():
	var RotZ = Globals.getStateRotZById()
	var RotY = Globals.getStateRotYById()
	var RotX = Globals.getStateRotXById()
	
	zMin.value=RotZ[0]
	zMax.value=RotZ[1]
	yMin.value=RotY[0]
	yMax.value=RotY[1]
	xMin.value=RotX[0]
	xMax.value=RotX[1]
	
	pass
	
func _on_z_min_value_changed(value):
	var RotZ = Globals.getStateRotZById()
	RotZ[0]=value
	pass # Replace with function body.


func _on_y_min_value_changed(value):
	var RotY = Globals.getStateRotYById()
	RotY[0]=value
	pass # Replace with function body.


func _on_x_min_value_changed(value):
	var RotX = Globals.getStateRotXById()
	RotX[0]=value
	pass # Replace with function body.


func _on_z_max_value_changed(value):
	var RotZ = Globals.getStateRotZById()
	RotZ[1]=value
	pass # Replace with function body.


func _on_y_max_value_changed(value):
	var RotY = Globals.getStateRotYById()
	RotY[1]=value
	pass # Replace with function body.


func _on_x_max_value_changed(value):
	var RotX = Globals.getStateRotXById()
	RotX[1]=value
	pass # Replace with function body.
