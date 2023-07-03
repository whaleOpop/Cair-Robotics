extends Control
@onready var Min=$TextureRect/HBoxContainer/Control/Min
@onready var Max=$TextureRect/HBoxContainer/Control2/Max
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func setUltraSonicByState():
	var ultra_sonic = Globals.getStateUltraById()
	Min.value=ultra_sonic[0]
	Max.value=ultra_sonic[1]
	pass

func _on_min_value_changed(value):
	var ultra_sonic = Globals.getStateUltraById()
	ultra_sonic[0]=value
	pass # Replace with function body.


func _on_max_value_changed(value):
	var ultra_sonic = Globals.getStateUltraById()
	ultra_sonic[1]=value
	pass # Replace with function body.
