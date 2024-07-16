extends Node3D

@onready var line_sensor = $tank_tracks_motion/LineSensor
@onready var color_sensor = $tank_tracks_motion/ColorSensor
@onready var car = $tank_tracks_motion
@onready var timer = $Timer

var _changeState = false
var state

func _ready():
	car.set_direction_in_degrees(float(Globals.RobotRot[0].y))

func _physics_process(delta):
	if car != null:
		var lineState = line_sensor.get_line_state()
		var colorState = color_sensor.get_color_state()
		
		if !_changeState:
			state = getState(lineState, colorState)
			set_wheel_engine_force([0, 0])
			_changeState = true
			print(state)
		if state != -1 and timer.time_left == 0.0:
			var stateItem = Globals.statmentList[state]
			timer.wait_time = Globals.getDurationValue(stateItem)
			
			timer.start() 
			set_wheel_engine_force(stateItem.speed)
		elif state == -1 and timer.time_left == 0.0:
			set_wheel_engine_force([0, 0])  # Stop the robot if state is -1 
func getState(lineState, colorState):
 # Инициализируем переменную со значением -1, чтобы обозначить отсутствие совпадений

	for i in range(Globals.statmentList.size()):
		# Получаем текущий элемент списка
		var statement_item = Globals.statmentList[i]
		# Проверяем совпадение строки и цвета
		if _compareColor(statement_item.color, colorState) and \
			_compareArrayLine(statement_item.line, lineState):
				return i  # Обновляем значение переменной statement
				  # Выходим из цикла, так как мы нашли первый совпадающий элемент
	return -1

func _compareColor(color, colorstate):
	print(color," ",colorstate[0].r8," ",colorstate[0].g8," ",colorstate[0].b8," ")
	return (color[0][0] <= colorstate[0].r8) and (color[0][1] >= colorstate[0].r8) and \
		(color[1][0] <= colorstate[0].g8) and (color[1][1] >= colorstate[0].g8) and \
		(color[2][0] <= colorstate[0].b8) and (color[2][1] >= colorstate[0].b8)


func _compareArrayLine(line, linestate):
	if line.size() != linestate.size():
		return false  # Размеры массивов не совпадают

	for i in range(line.size()):
		if line[i] != 2 and line[i] != linestate[i]:
			return false
	return true

func _on_timer_timeout():
	_changeState = false

func set_wheel_engine_force(speed):
	var clamped_speed = [
		clamp(speed[0], -100, 100),
		clamp(speed[1], -100, 100)
	]

	car.set_left_track_speed_percent(clamped_speed[0])
	car.set_right_track_speed_percent(clamped_speed[1])
