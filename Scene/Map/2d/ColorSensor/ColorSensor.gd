extends Control

@onready var RedMin = $RedMin
@onready var GreenMin = $GreenMin
@onready var BlueMin = $BlueMin
@onready var RedMax = $RedMax
@onready var GreenMax = $GreenMax
@onready var BlueMax = $BlueMax
@onready var colorRect = $ColorRect



# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func setColorByState():
	var red = Globals.getStateColorRedById()
	var green = Globals.getStateColorGreenById()
	var blue = Globals.getStateColorBlueById()
	RedMin.text=var_to_str(red[0])
	RedMax.text=var_to_str(red[1])
	GreenMin.text=var_to_str(green[0])
	GreenMax.text=var_to_str(green[1])
	BlueMin.text=var_to_str(blue[0])
	BlueMax.text=var_to_str(blue[1])

	pass

func _on_red_min_text_changed(new_text):
	var red = Globals.getStateColorRedById()
	red[0]=str_to_var(new_text)
	
	pass # Replace with function body.


func _on_green_min_text_changed(new_text):
	var green = Globals.getStateColorGreenById()
	green[0]=str_to_var(new_text)
	pass # Replace with function body.


func _on_blue_min_text_changed(new_text):
	var blue = Globals.getStateColorBlueById()
	blue[0]=str_to_var(new_text)
	pass # Replace with function body.


func _on_red_max_text_changed(new_text):
	var red = Globals.getStateColorRedById()
	red[1]=str_to_var(new_text)
	pass # Replace with function body.


func _on_green_max_text_changed(new_text):
	var green = Globals.getStateColorGreenById()
	green[1]=str_to_var(new_text)
	pass # Replace with function body.


func _on_blue_max_text_changed(new_text):
	var blue = Globals.getStateColorBlueById()
	blue[1]=str_to_var(new_text)
	pass # Replace with function body.
