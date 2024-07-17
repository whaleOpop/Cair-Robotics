"""
Краткое описание:
Этот код описывает класс "Statement", который наследуется от класса Node в Godot Engine. Он имеет конструктор, который принимает параметр "param_name". Также он содержит переменные, которые будут использоваться в программе:

stName: строка, задающая имя выражения
line: список из шести значений, представляющий линии на экране
ultrasonic: список из двух значений, представляющий расстояние, определенное ультразвуковым датчиком
colorGreen: список из двух значений, представляющий зеленый цвет
colorRed: список из двух значений, представляющий красный цвет
colorBlue: список из двух значений, представляющий синий цвет
speed: список из двух значений, представляющий скорость движения
rotationX: список из двух значений, представляющий вращение по оси X
rotationZ: список из двух значений, представляющий вращение по оси Z
rotationY: список из двух значений, представляющий вращение по оси Y
led: список из одного значения, представляющий состояние светодиода
time: список из двух значений, представляющий временной интервал
duration: список из одного значения, представляющий длительность
steering: список из одного значения, представляющий угол поворота.
Библиотеки, используемые в программе:
Отсутствуют.
"""


extends Node
class_name Statment 
	
func _init(param_name: String = "") -> void:
	stName = param_name
	
var stName : String
var line : Array = [2,2,2,2,2,2]
var ultrasonic : Array = [0,100]
var colorGreen : Array = [0,255]
var colorRed : Array = [0,255]
var colorBlue : Array = [0,255]
var color : Array = [colorRed,colorGreen,colorBlue]
var speed : Array = [0,0]
var rotationX : Array = [0,0]
var rotationZ : Array = [0,0]
var rotationY : Array = [0,0]
var led : Array = [0]
var time : Array = [0,1000]
var duration : Array = [0]
var steering : Array = [0]





func to_dict() -> Dictionary:
	return {
		"stName": stName,
		"line": line,
		"ultrasonic": ultrasonic,
		"colorRed": colorRed,
		"colorGreen": colorGreen,
		"colorBlue": colorBlue,
		"speed": speed,
		"rotationX": rotationX,
		"rotationZ": rotationZ,
		"rotationY": rotationY,
		"led": led,
		"time": time,
		"duration": duration,
		"steering": steering
	}

static func from_dict(dict: Dictionary) -> Statment:
	var statment = Statment.new()
	statment.stName = dict["stName"]
	statment.line = dict["line"]
	statment.ultrasonic = dict["ultrasonic"]
	statment.colorRed = dict["colorRed"]
	statment.colorGreen = dict["colorGreen"]
	statment.colorBlue = dict["colorBlue"]
	statment.speed = dict["speed"]
	statment.rotationX = dict["rotationX"]
	statment.rotationZ = dict["rotationZ"]
	statment.rotationY = dict["rotationY"]
	statment.led = dict["led"]
	statment.time = dict["time"]
	statment.duration = dict["duration"]
	statment.steering = dict["steering"]
	return statment


