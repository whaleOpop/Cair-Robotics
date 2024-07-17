extends Panel
@onready var MapLoader = $"../../../SubViewportContainer/SubViewport/MapLoader"

@onready var stateText = $State
@onready var timeText = $Time
@onready var wheelLeft = $WheelLeft
@onready var wheelRight = $WheelRight
@onready var ultrasonic = $Ultrasonic 
@onready var led = $Led
@onready var line = $Line
@onready var red =$Color/Red/TextureRect/Red
@onready var green =$Color/Control2/TextureRect/Green
@onready var blue =$Color/Control3/TextureRect/Blue
var Car


func _ready():
	pass 

func getCar():
	if MapLoader:
		for i in MapLoader.get_children():
			if i.get("metadata/Name") =="Car":
				Car=i

func _process(_delta):
	if Car:
		set_led(Car.get_led_state())
		set_speed(Car.get_speed_state())
		set_line(Car.get_line_state())
		set_color(Car.get_color_state())
		set_ultra(Car.get_ultra_sonic_state())
		set_time(Car.get_timer_state())
		set_state(Car.get_state_now())
	pass
func set_led(state):
	led.text = "Led: "+ str(state)
func set_speed(state):
	wheelLeft.text = "$WheelLeft: "+str(state[0])
	wheelRight.text ="$WheelRight: "+ str(state[1])
	pass
func set_color(state):
	red.text=str(state[0].r8)
	green.text=str(state[0].g8)
	blue.text=str(state[0].b8)
	pass

func set_ultra(state):
	ultrasonic.text="Ultrasonic: "+str(state[0])
	pass
func set_state(state):
	stateText.text="State: "+str(Globals.getStateById(state))
	pass
	
func set_time(state):
	timeText.text="Time: "+str(state)
	pass
func set_line(state):
	var count = 0
	for i in line.get_children():
		
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
