extends Node3D

# Declare variables with @onready to initialize them when the scene is ready
@onready var line_sensor = $tank_tracks_motion/LineSensor
@onready var color_sensor = $tank_tracks_motion/ColorSensor
@onready var car = $tank_tracks_motion
@onready var timer = $Timer
@onready var time_sensor = $tank_tracks_motion/TimeSensor
@onready var ultra_sonic_sensor = $tank_tracks_motion/UltraSonicSensor
@onready var led = $tank_tracks_motion/Led

var change_state = false
var state

func _ready():
	# Set the initial direction of the car based on the global rotation value
	car.set_direction_in_degrees(float(Globals.RobotRot[0].y))

func _physics_process(delta):
	if car != null:
		# Gather sensor states
		var line_state = line_sensor.get_line_state()
		var color_state = color_sensor.get_color_state()
		var timer_state = time_sensor.get_time_state()
		var ultra_sonic_state = ultra_sonic_sensor.get_distances()
		print(ultra_sonic_state)
		# Print sensor states for debugging purposes

		
		if not change_state:
			# Determine the current state based on sensor inputs
			state = get_state(line_state, color_state, timer_state, ultra_sonic_state)
			set_wheel_engine_force([0, 0])
			change_state = true
			
		print(state)
		if state != -1 and timer.time_left == 0.0:
			# Get the current state item from the global statement list
			var state_item = Globals.statmentList[state]
			
			# Set the timer duration based on the state item
			timer.wait_time = Globals.getDurationValue(state_item)
			
			
			# Start the timer and set the car's speed and LED status
			timer.start() 
			set_wheel_engine_force(state_item.speed)
			led.set_led(state_item.led[0])
		elif state == -1 and timer.time_left == 0.0:
			# Stop the car if no valid state is found
			set_wheel_engine_force([0, 0])
			led.set_led(0)
			state = get_state(line_state, color_state, timer_state, ultra_sonic_state)

func get_led_state():
	return led.get_state_led()
func get_speed_state():
	return [car.get_speedL(),car.get_speedR()]
func get_line_state():
	return line_sensor.get_line_state()

func get_color_state():
	return color_sensor.get_color_state()

func get_timer_state():
	return time_sensor.get_time_state()

func get_ultra_sonic_state():
	return ultra_sonic_sensor.get_distances()
	
func get_state_now():
	return state
	pass
	
func get_state(line_state, color_state, timer_state, ultra_sonic_state):
	for i in range(Globals.statmentList.size()):
		var statement_item = Globals.statmentList[i]
		if compare_time(statement_item.time, timer_state) and \
		compare_color(statement_item.color, color_state) and \
			compare_array_line(statement_item.line, line_state) and \
			compare_ultra_sonic(statement_item.ultrasonic, ultra_sonic_state):
			return i
	return -1

func compare_time(timer_range, timer_state):
	
	return (timer_range[0] <= timer_state) and (timer_range[1] >= timer_state)

func compare_ultra_sonic(ultra_sonic_range, ultra_sonic_state):
	return (ultra_sonic_range[0] <= ultra_sonic_state[0]) and (ultra_sonic_range[1] >= ultra_sonic_state[0])

func compare_color(color_range, color_state):
	return (color_range[0][0] <= color_state[0].r8) and (color_range[0][1] >= color_state[0].r8) and \
		   (color_range[1][0] <= color_state[0].g8) and (color_range[1][1] >= color_state[0].g8) and \
		   (color_range[2][0] <= color_state[0].b8) and (color_range[2][1] >= color_state[0].b8)

func compare_array_line(line_pattern, line_state):
	if line_pattern.size() != line_state.size():
		return false  # Array sizes do not match

	for i in range(line_pattern.size()):
		if line_pattern[i] != 2 and line_pattern[i] != line_state[i]:
			return false
	return true

func _on_timer_timeout():
	change_state = false

func set_wheel_engine_force(speed):
	var clamped_speed = [
		clamp(speed[0], -100, 100),
		clamp(speed[1], -100, 100)
	]

	car.set_left_track_speed_percent(clamped_speed[0])
	car.set_right_track_speed_percent(clamped_speed[1])
