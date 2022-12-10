extends Control

signal getStatment(nameSt)



onready var st = get_node("/root/Statments")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


var something setget set_something 

func set_something(value):
	something = value
	$'.'.set("text",value)
	pass



func seatchElem(CurrentSt):
	var index
	for i in range(0,st.StatmentList.size()):
		if CurrentSt==st.StatmentList[i].stName:
			index =i
	print(index)
	return index
	
	



func _on_Button_button_down():
	emit_signal("getStatment",$'.'.get("text"))
	for i in range(0,st.StatmentList.size()):
		if(st.StatmentList[i].stName==$'.'.get("text")):
			st.CurrentSt=$'.'.get("text")
	pass # Replace with function body.
