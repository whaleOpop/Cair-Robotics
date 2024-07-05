extends Control
@onready var textMin = $TextureRect/timeMin
@onready var textMax = $TextureRect/timeMax

# Called when the node enters the scene tree for the first time.
func _ready():
	size.x=1
	size.y=1
	pass # Replace with function body.


func setTimeByState():
	var time = Globals.getStateTimeById()
	textMin.text=var_to_str(time[0])
	textMax.text=var_to_str(time[1])
	pass

func _on_time_max_text_changed(new_text):
	var time = Globals.getStateTimeById()
	time[0]=str_to_var(new_text)
	pass # Replace with function body.


func _on_time_min_text_changed(new_text):
	var time = Globals.getStateTimeById()
	time[1]=str_to_var(new_text)
	pass # Replace with function body.
