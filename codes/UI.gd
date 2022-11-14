extends Node

onready var ui = get_node("/root/AutoLoad")

onready var L1 : ColorRect = $CanvasLayer/L1
onready var L2 : ColorRect = $CanvasLayer/L2
onready var L3 : ColorRect = $CanvasLayer/L3
onready var R1 : ColorRect = $CanvasLayer/R1
onready var R2 : ColorRect = $CanvasLayer/R2
onready var R3 : ColorRect = $CanvasLayer/R3
func _ready():
	ui.moveFlag_set("Stop")
	
	pass
func _process(delta):
	if(ui.l1==1):
		L1.color = Color(1, 1, 1, 1)
	else:
		L1.color = Color(0, 0, 0, 1)
	
	if(ui.l2==1):
		L2.color = Color(1, 1, 1, 1)
	else:
		L2.color = Color(0, 0, 0, 1)
	
	if(ui.l3==1):
		L3.color = Color(1, 1, 1, 1)
	else:
		L3.color = Color(0, 0, 0, 1)
	
	if(ui.r3==1):
		R3.color = Color(1, 1, 1, 1)
	else:
		R3.color = Color(0, 0, 0, 1)
		
	if(ui.r2==1):
		R2.color = Color(1, 1, 1, 1)
	else:
		R2.color = Color(0, 0, 0, 1)
		
	if(ui.r1==1):
		R1.color = Color(1, 1, 1, 1)
	else:
		R1.color = Color(0, 0, 0, 1)
		pass


func _on_Right_pressed():
	ui.moveFlag_set("Right")
	pass # Replace with function body.
	


func _on_Stop_pressed():
	ui.moveFlag_set("Stop")
	pass # Replace with function body.


func _on_Left_pressed():
	ui.moveFlag_set("Left")
	pass # Replace with function body.
	

	
