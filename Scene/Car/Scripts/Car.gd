extends Node3D

@onready var line_sensor = $tank_tracks_motion/LineSensor
@onready var color_sensor = $tank_tracks_motion/ColorSensor
@onready var car = $tank_tracks_motion
@onready var timer = $Timer
var _changeState = false
var state

# Максимальный угол поворота для передних и задних колёс
var max_steering_angle_front = 45.0
var max_steering_angle_rear = 30.0

func _ready():
	car.set_direction_in_degrees(float(Globals.RobotRot[0].y))
	pass

func _physics_process(delta):
	if car != null:
		var lineState = line_sensor.get_line_state()
		var colorState= color_sensor.get_color_state()
		print(lineState)
		if !_changeState:
			state = getState(lineState)
			_changeState = true
		
		if state != null:
			var stateItem = Globals.statmentList[state]
			timer.wait_time = Globals.getDurationValue(stateItem)
			
			set_wheel_engine_force(stateItem.speed)

			
func getState(lineState):
	for i in range(Globals.statmentList.size()):
		if _compareArrayLine(Globals.statmentList[i].line, lineState):
			return i
	return null

func _compareArrayLine(line, linestate):
	var mask = [false, false, false, false, false, false]
	for i in range(line.size()):
		if line[i] != 2:
			mask[i] = true
			
	for i in range(line.size()):
		if mask[i]:
			if line[i] != linestate[i]:
				return false
	return true

func _on_timer_timeout():
	_changeState = false
	pass # Replace with function body.

func calculate_steering_angles(speed_diff):
	# Calculate steering angles based on clamped speed difference
	var clamped_speed_diff = clamp(speed_diff, -100, 100)
	
	var steering_angle_front = (clamped_speed_diff / 100.0) * max_steering_angle_front
	var steering_angle_rear = (clamped_speed_diff / 100.0) * max_steering_angle_rear
	
	return {
		"front_left": -steering_angle_front,
		"front_right": steering_angle_front,
		"rear_left": steering_angle_rear,
		"rear_right": -steering_angle_rear
	}


func set_wheel_engine_force(speed):
	# Clamp speeds between -100 and 100
	var clamped_speed = [
		clamp(speed[0], -100, 100),
		clamp(speed[1], -100, 100)
	]

	# Set engine forces
	car.set_left_track_speed_percent(clamped_speed[0])
	car.set_right_track_speed_percent(clamped_speed[1])

