extends RigidBody3D

class_name TankTracksMotion
# Класс `TankTracksMotion` наследуется от `RigidBody3D` и предназначен для управления движением танка в игровом движке Godot Engine.
# Танк может двигаться вперед, назад, влево и вправо, а также поворачивать, используя два тракта.

# `mesh` ссылается на меш, который представляет физическую форму танка.
@onready var mesh = $Mesh

# Константы, определяющие максимальную скорость, ускорение, замедление и угловое ускорение танка.
const MAX_SPEED = 5.0
const ACCELERATION = 20.0
const DECELERATION = 10.0
const TURN_SPEED = 0.2

# Переменные для управления скоростью левого и правого трактов в процентах.
var leftTrackSpeedPercent = 0
var rightTrackSpeedPercent = 0

# Переменная для хранения текущего направления движения танка в градусах.
var movement_degrees = 0.0

# Функция `set_direction_in_degrees(degrees)` устанавливает направление движения танка в градусах.
func set_direction_in_degrees(degrees):
	# Нормализация градусов так, чтобы они были в диапазоне от 0 до 360
	movement_degrees = fmod(degrees, 360.0)
	if movement_degrees < 0:
		movement_degrees += 360.0

# Функция `_process(_delta)` вызывается на каждом кадре и отвечает за обновление положения и ориентации танка.
func _process(_delta):
	var leftTrackSpeed = MAX_SPEED * (leftTrackSpeedPercent / 100.0) * 2.0
	var rightTrackSpeed = MAX_SPEED * (rightTrackSpeedPercent / 100.0) * 2.0
	var direction_rad = deg_to_rad(movement_degrees)
	
	# Расчет векторов вперед и вправо на основе градусов
	var forward = Vector3(cos(direction_rad), 0, sin(direction_rad))
	
	# Расчет линейных скоростей на основе скорости трактов и направления
	var average_speed = (leftTrackSpeed + rightTrackSpeed) * 0.5
	var linear_velocities = forward * average_speed
	
	# Корректировка направления линейной скорости на основе угла
	if movement_degrees == 0:
		linear_velocities = transform.basis.z.normalized() * average_speed
	elif movement_degrees == 180:
		linear_velocities = -transform.basis.z.normalized() * average_speed
	elif movement_degrees == 90:
		linear_velocities = transform.basis.x.normalized() * average_speed
	elif movement_degrees == 270:
		linear_velocities = -transform.basis.x.normalized() * average_speed
	
	set_linear_velocity(-linear_velocities)
	
	# Расчет угловой скорости
	var angular_velocities = (rightTrackSpeed - leftTrackSpeed) * TURN_SPEED
	set_angular_velocity(Vector3(0, angular_velocities, 0))

# Функции `set_left_track_speed_percent(percent)` и `set_right_track_speed_percent(percent)` устанавливают скорость левого и правого трактов соответственно.
func set_left_track_speed_percent(percent):
	leftTrackSpeedPercent = clamp(percent, -200, 200)

func set_right_track_speed_percent(percent):
	rightTrackSpeedPercent = clamp(percent, -200, 200)

# Функции `get_speedL()` и `get_speedR()` возвращают текущие скорости левого и правого трактов соответственно.
func get_speedL():
	return leftTrackSpeedPercent
	
func get_speedR():
	return rightTrackSpeedPercent
