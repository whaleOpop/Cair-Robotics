extends Node3D

class_name Led

@onready var led_mesh = $CSGBox3D
@onready var led_anim = $"../../AnimationPlayer"
var ledState
func _ready():
	led_mesh.visible=false
	pass 

func set_led(index):
	if index==0:
		offLed()
	elif index ==1:
		onLed()
	elif index == 2:
		flashLed()
	pass

func offLed():
	led_mesh.visible=false
	ledState=0
	pass 
func get_state_led():
	return ledState
func onLed():
	led_mesh.visible=true
	ledState=1
	pass
	
func flashLed():
	led_anim.play("FLASH")
	ledState=1
	pass


