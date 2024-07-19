extends Node

class_name LineSensor
# Эта часть кода определяет класс `LineSensor`, который расширяет базовый класс `Node`.
# Класс предназначен для использования в качестве датчика линии в игровом движке Godot Engine,
# позволяя обнаруживать различные объекты по цвету и изменять свойство материала деталей датчика в зависимости от состояния линии.

# Список датчиков (RayCast3D) используется для хранения всех дочерних узлов, которые являются датчиками.
var sensors: Array[RayCast3D] = []

# Определение основных цветов, используемых для идентификации различных типов объектов.
var white = Color.WHITE
var black = Color.BLACK

# Загрузка материалов для изменения цвета деталей датчика в соответствии с обнаруженными объектами.
var white_material: StandardMaterial3D = load("res://Scene/Car/Material/white_transperent.tres") as StandardMaterial3D
var black_transperent: StandardMaterial3D = load("res://Scene/Car/Material/black_transperent.tres") as StandardMaterial3D

# Функция вызывается при готовности узла к работе.
# Она заполняет список датчиков всеми дочерними узлами текущего узла.
func _ready():
	for i in get_children():
		sensors.append(i)

# Основная функция для получения состояния линии, проходящей через все датчики.
# Возвращает массив состояний, где 1 означает белый объект, а 0 - черный.
func get_line_state():
	var line_state = []
	for sensor in sensors:
		var state = get_sensor_state(sensor)
		line_state.append(state)
		change_sensor_color(sensor, state)
	return line_state

# Функция для изменения цвета детали датчика в зависимости от его состояния.
# Если состояние равно 1, то материал устанавливается в белый, иначе - в черный.
func change_sensor_color(sensor, state):
	if state == 1:
		sensor.get_child(0).set("material_override", white_material)
	else:
		sensor.get_child(0).set("material_override", black_transperent)

# Функция для определения состояния датчика.
# Проверяет, сталкивается ли датчик с объектом, и если да, то проверяет его цвет.
# Возвращает 1, если объект белый, и 0, если черный.
func get_sensor_state(sensor):
	if sensor.is_colliding():
		var col = sensor.get_collider()
		if col and col.has_method("_get_color"):
			if col._get_color() == white:
				return 1
			elif col._get_color() == black:
				return 0
	return 0
