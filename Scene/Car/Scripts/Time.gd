extends Node3D

class_name TimeSensor

var timer = Timer.new()
var seconds = 0
func _ready():
	add_child(timer)
	timer.wait_time=1
	timer.autostart=true
	timer.start()
	timer.connect("timeout",_timeout)
	pass 
	

func get_time_state():
	return seconds

func _timeout():
	seconds+=1
	pass

