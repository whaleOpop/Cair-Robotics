"""
Краткое описание:
Данный скрипт отвечает за движение автомобиля на карте. Скрипт использует шесть лучей LRay и RRay,
каждый из которых пересекается с карточкой в текущем положении автомобиля, чтобы определить цвет 
карточки под каждым лучом. Если цвет карточки белый, то соответствующий элемент массива lineState 
устанавливается в значение 1, если черный - в значение 0.

Затем функция getState сравнивает значения массива lineState с заранее определенными состояниями 
автомобиля из списка Globals.statmentList. Если найдено соответствующее состояние, то происходит 
изменение параметров движения автомобиля: устанавливаются значения для двигателя и рулевого колеса 
соответствующие выбранному состоянию.

Функция _compareArrayLine используется при сравнении состояний автомобиля. Она сравнивает массивы 
line и linestate и возвращает true, если они совпадают.

Кроме того, скрипт содержит функцию _on_timer_timeout, которая сбрасывает флаг _changeState после 
таймера, чтобы обновить состояние автомобиля на следующем кадре.
"""

extends Node3D

@onready var l3 = $VehicleBody/LRay3
@onready var l2 = $VehicleBody/LRay2
@onready var l1 = $VehicleBody/LRay1
@onready var r1 = $VehicleBody/RRay1
@onready var r2 = $VehicleBody/RRay2
@onready var r3 = $VehicleBody/RRay3

@onready var LWheelBac = $VehicleBody/LWheelBac
@onready var LWheelFor = $VehicleBody/LWheelFor
@onready var RWheelBac = $VehicleBody/RWheelBac
@onready var RWheelFor = $VehicleBody/RWheelFor
@onready var Car = $VehicleBody
var lineState = [0, 0, 0, 0, 0, 0]

func _ready():

		
	pass
var white = Color.WHITE
var black = Color.BLACK
var _changeState = false
var state 
func _physics_process(delta):
	if Car!=null:
		handleRayCollision(l3, 0)
		handleRayCollision(l2, 1)
		handleRayCollision(l1, 2)
		handleRayCollision(r1, 3)
		handleRayCollision(r2, 4)
		handleRayCollision(r3, 5)
		print(lineState)
		if !_changeState:
			state = getState(lineState)
			_changeState=true
		
		print(state)
		print()
		if state != null:
			var stateItem = Globals.statmentList[state]
			$Timer.wait_time = Globals.getDurationValue(stateItem)
			
			LWheelBac.engine_force =stateItem.speed[0]
			LWheelFor.engine_force = stateItem.speed[0]
			RWheelBac.engine_force = stateItem.speed[1]
			RWheelFor.engine_force = stateItem.speed[1]
			if Car.steering!=stateItem.steering[0]:
				Car.steering = -float(lerp(Car.steering, float(stateItem.steering[0]), delta))
				
			
			

#		else:
#			Car.freeze=true
		
	
func handleRayCollision(ray, index):
	if ray.is_colliding():
		var col = ray.get_collider()
		if col._get_color() == white:
			lineState[index] = 1
		elif col._get_color() == black:
			lineState[index] = 0


func getState(lineState):
	for i in range(Globals.statmentList.size()):
		if _compareArrayLine(Globals.statmentList[i].line, lineState):
			return i
	return null


func _compareArrayLine(line, linestate):
	var mask = [false,false,false,false,false,false]
	for i in range(line.size()):
		if line[i] != 2:
			mask[i]=true
			
	for i in range(line.size()):	
		if mask[i]:
			if line[i] != linestate[i]:
				return false
	return true



func _on_timer_timeout():
	_changeState=false
	pass # Replace with function body.
