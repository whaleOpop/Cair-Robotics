extends Node3D

# Этот скрипт представляет собой основной контроллер для робота в игровом движке Godot Engine.
# Он использует различные датчики и таймер для управления поведением робота в зависимости от условий окружающей среды.

# Датчики и другие компоненты робота инициализируются через директиву `@onready`.
@onready var line_sensor = $tank_tracks_motion/LineSensor
@onready var color_sensor = $tank_tracks_motion/ColorSensor
@onready var car = $tank_tracks_motion
@onready var timer = $Timer
@onready var time_sensor = $tank_tracks_motion/TimeSensor
@onready var ultra_sonic_sensor = $tank_tracks_motion/UltraSonicSensor
@onready var led = $tank_tracks_motion/Led

# Флаг `change_state` используется для контроля переключения между различными состояниями робота.
var change_state = false

# Переменная `state` хранит текущее состояние робота, определенное на основе данных с датчиков.
var state
# Функция `_ready()` вызывается при инициализации узла.
# Здесь устанавливается начальная направленность движения робота.

func _ready():
	car.set_direction_in_degrees(float(Globals.RobotRot[0].y))

# Функция `_physics_process(_delta)` вызывается на каждом кадре физического процесса.
# Она собирает данные с датчиков и определяет следующее состояние робота.

func _physics_process(_delta):
	if car != null:
		var line_state = line_sensor.get_line_state()
		var color_state = color_sensor.get_color_state()
		var timer_state = time_sensor.get_time_state()
		var ultra_sonic_state = ultra_sonic_sensor.get_distances()

		if not change_state:
			state = get_state(line_state, color_state, timer_state, ultra_sonic_state)
			set_wheel_engine_force([0, 0])
			change_state = true
		
		if state != -1 and timer.time_left == 0.0:
			var state_item = Globals.statmentList[state]
			timer.wait_time = Globals.getDurationValue(state_item)
			timer.start()
			set_wheel_engine_force(state_item.speed)
			led.set_led(state_item.led[0])
		elif state == -1 and timer.time_left == 0.0:
			set_wheel_engine_force([0, 0])
			led.set_led(0)
			state = get_state(line_state, color_state, timer_state, ultra_sonic_state)

# Функции `get_*_state()` используются для доступа к текущему состоянию различных систем робота.

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

# Функция `get_state()` сравнивает текущие состояния датчиков с условиями из глобального списка действий.
func get_state(line_state, color_state, timer_state, ultra_sonic_state):
	for i in range(Globals.statmentList.size()):
		var statement_item = Globals.statmentList[i]
		if compare_time(statement_item.time, timer_state) and \
		compare_color(statement_item.color, color_state) and \
			compare_array_line(statement_item.line, line_state) and \
			compare_ultra_sonic(statement_item.ultrasonic, ultra_sonic_state):
			return i
	return -1

# Функции сравнения используются для проверки соответствия текущих состояний датчиков условиям действия.
func compare_time(timer_range, timer_state):
	return (timer_range[0] <= timer_state) and (timer_range[1] >= timer_state)

func compare_ultra_sonic(ultra_sonic_range, ultra_sonic_state):
	return (ultra_sonic_range[0] <= ultra_sonic_state[0]) and (ultra_sonic_range[1] >= ultra_sonic_state[0])

func compare_color(color_range, color_state):
	# color_range: [[min_r, max_r], [min_g, max_g], [min_b, max_b]]
	# color_state: [{'r8': int, 'g8': int, 'b8': int}]
	var is_r_in_range = (color_range[0][0] <= color_state[0].r8) and (color_state[0].r8 <= color_range[0][1])
	var is_g_in_range = (color_range[1][0] <= color_state[0].g8) and (color_state[0].g8 <= color_range[1][1])
	var is_b_in_range = (color_range[2][0] <= color_state[0].b8) and (color_state[0].b8 <= color_range[2][1])
	return is_r_in_range and is_g_in_range and is_b_in_range

func compare_array_line(line_pattern, line_state):
	if line_pattern.size() != line_state.size():
		return false
	for i in range(line_pattern.size()):
		if line_pattern[i] != 2 and line_pattern[i] != line_state[i]:
			return false
	return true

# Функция `_on_timer_timeout()` сбрасывает флаг `change_state` после завершения таймера.
func _on_timer_timeout():
	change_state = false

# Функция `set_wheel_engine_force()` применяет силу к двигателям робота для управления скоростью.
func set_wheel_engine_force(speed):
	var clamped_speed = [
		clamp(speed[0], -100, 100),
		clamp(speed[1], -100, 100)
	]
	car.set_left_track_speed_percent(clamped_speed[0])
	car.set_right_track_speed_percent(clamped_speed[1])
