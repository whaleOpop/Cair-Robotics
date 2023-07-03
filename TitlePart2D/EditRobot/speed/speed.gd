extends Control

@onready var LeftWheel = $TextureRect/LeftWheel
@onready var RightWheel = $TextureRect/RightWheel
@onready var RotateWheelAngel = $TextureRect/RotateWheelAngel
@onready var HSliders = $TextureRect/HSlider
func setSpeedByState():
	var speed = Globals.getStateSpeedById()
	var steering= Globals.getSteeringById()
	LeftWheel.value=speed[0]
	RightWheel.value=speed[1]
	HSliders.value=steering[0]
	RotateWheelAngel.value=steering[0]

func _on_left_wheel_value_changed(value):
	var speed = Globals.getStateSpeedById()
	speed[0]=value
	pass # Replace with function body.


func _on_right_wheel_value_changed(value):
	var speed = Globals.getStateSpeedById()
	speed[1]=value
	pass # Replace with function body.



func _on_h_slider_value_changed(valued):
	RotateWheelAngel.value=valued
	pass # Replace with function body.


func _on_rotate_wheel_angel_value_changed(value):
	var steering = Globals.getSteeringById()
	steering[0]=value
	pass # Replace with function body.
