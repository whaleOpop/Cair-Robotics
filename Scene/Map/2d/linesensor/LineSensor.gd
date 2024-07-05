extends Control

@onready var l3 = $HBoxContainer/Control/l3
@onready var l2 = $HBoxContainer/Control2/l2
@onready var l1 = $HBoxContainer/Control3/l1
@onready var r1 = $HBoxContainer/Control4/r1
@onready var r2 = $HBoxContainer/Control5/r2
@onready var r3 = $HBoxContainer/Control6/r3
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.





func setLineByState():
	var line = Globals.getStateLineById()
	l3.select(line[0])
	l2.select(line[1])
	l1.select(line[2])
	r1.select(line[3])
	r2.select(line[4])
	r3.select(line[5])
	pass
	
func _on_l_3_item_selected(index):
	var line = Globals.getStateLineById()
	line[0]=index
	pass # Replace with function body.


func _on_l_2_item_selected(index):
	var line = Globals.getStateLineById()
	line[1]=index
	pass # Replace with function body.


func _on_l_1_item_selected(index):
	var line = Globals.getStateLineById()
	line[2]=index
	pass # Replace with function body.


func _on_r_1_item_selected(index):
	var line = Globals.getStateLineById()
	line[3]=index
	pass # Replace with function body.


func _on_r_2_item_selected(index):
	var line = Globals.getStateLineById()
	line[4]=index
	pass # Replace with function body.


func _on_r_3_item_selected(index):
	var line = Globals.getStateLineById()
	line[5]=index
	pass # Replace with function body.
