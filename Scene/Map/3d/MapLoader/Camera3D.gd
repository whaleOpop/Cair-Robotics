"""
Краткое описание:
Этот скрипт позволяет пользователю управлять камерой в 3D-сцене. Камера перемещается в зависимости
 от ввода пользователя, который обрабатывается функцией get_input.

В данном случае, при нажатии на клавиши "right" и "left" камера движется по оси X вправо и влево 
соответственно с заданным speed. При нажатии на клавиши "down" и "up" камера движется по оси Z вперед 
и назад.

Также, при нажатии на клавишу "zoomUp" камера приближается к объекту, а при нажатии на клавишу 
"zoomDown" камера отдаляется от объекта. Это происходит путем изменения координаты Y камеры с заданным speed.

Функция _process вызывается ежекадрово и используется для перемещения камеры на основе значения
velocity, которое получено из функции get_input."""
extends Camera3D

var target_position = Vector3(0,20,0)
var velocity = Vector3.ZERO
var acceleration = 10
var damping = 0.1

func _process(delta):
	target_position = get_input(target_position,delta)
	velocity = velocity.lerp(target_position - position, damping)
	
	position += velocity * delta
	
	pass
func _ready():
	$".".position.y=0
	pass
func get_input(_position,delta):
	if Input.is_action_pressed("right"):
		_position.x += acceleration*delta
	elif Input.is_action_pressed("left"):
		_position.x -= acceleration*delta
	if Input.is_action_pressed("down"):
		_position.z += acceleration*delta
	elif Input.is_action_pressed("up"):
		_position.z -= acceleration*delta
	if Input.is_action_just_released("zoomUp"):
		_position.y -= acceleration*delta    
	elif Input.is_action_just_released("zoomDown"):
		_position.y += acceleration*delta
	return _position
