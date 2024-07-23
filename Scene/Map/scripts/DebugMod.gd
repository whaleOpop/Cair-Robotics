extends Panel
@onready var map_loader = $"../../../SubViewportContainer/SubViewport/map_loader"

@onready var state_label = $state_label
@onready var time_label = $time_label
@onready var wheel_left_label = $wheel_left_label
@onready var wheel_right_label = $wheel_right_label
@onready var ultra_sonic_label = $ultra_sonic_label
@onready var led_label = $led_label
@onready var line_visual = $line_visual
@onready var red_label = $Color/Control/TextureRect/red_label
@onready var green_label = $Color/Control2/TextureRect/green_label
@onready var blue_label = $Color/Control3/TextureRect/blue_label
var Car


func _ready():
	pass 

func getCar():
	if map_loader:
		for i in map_loader.get_children():
			if i.get("metadata/Name") =="Car":
				Car=i

func _process(_delta):
	if Car!=null:
		set_led(Car.get_led_state())
		set_speed(Car.get_speed_state())
		set_line(Car.get_line_state())
		set_color(Car.get_color_state())
		set_ultra(Car.get_ultra_sonic_state())
		set_time(Car.get_timer_state())
		set_state(Car.get_state_now())
	pass
func set_led(state):
	led_label.text = "Led: "+ str(state)
func set_speed(state):
	wheel_left_label.text = "$WheelLeft: "+str(state[0])
	wheel_right_label.text ="$WheelRight: "+ str(state[1])
	pass
func set_color(state):
	red_label.text=str(state[0].r8)
	green_label.text=str(state[0].g8)
	blue_label.text=str(state[0].b8)
	pass

func set_ultra(state):
	ultra_sonic_label.text="Ultrasonic: "+str(state[0])
	pass
func set_state(state):
	state_label.text="State: "+str(Globals.getStateById(state))
	pass
	
func set_time(state):
	time_label.text="Time: "+str(state)
	pass
func set_line(state):
	var count = 0
	for i in line_visual.get_children():
		
		if state[count]==0:
			i.get_child(1).show()
		else:
			i.get_child(1).hide()
		count+=1
	pass
	

func _on_draw():
	getCar()
	pass # Replace with function body.


func _on_hidden():
	Car=null
	pass # Replace with function body.
