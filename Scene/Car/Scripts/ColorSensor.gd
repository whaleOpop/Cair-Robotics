extends Node3D

class_name ColorSensor
# Этот класс `ColorSensor` наследуется от `Node3D` и предназначен для использования в качестве датчика цвета в игровом движке Godot Engine.
# Он позволяет обнаруживать объекты вокруг и изменять свойство материала деталей датчика в зависимости от цвета обнаруженного объекта.

# Список датчиков (`RayCast3D`) используется для хранения всех дочерних узлов, которые являются датчиками цвета.
var sensors: Array[RayCast3D] = []

# Функция `_ready()` вызывается при инициализации узла.
# Она проходит через все дочерние узлы и добавляет те из них, которые являются экземплярами `RayCast3D`, в список датчиков.
func _ready():
	for i in get_children():
		if i is RayCast3D:
			sensors.append(i)
	pass 

# Функция `get_color_state()` используется для получения текущего состояния цвета.
# Она инициализирует массив `color_state` одним белым цветом и затем обновляет этот массив на основе результатов работы датчиков.
func get_color_state():
	var color_state:Array[Color]=[Color(255,255,255,255)] # Инициализация массива одним белым цветом.
	for sensor in sensors:
		var state = get_sensor_color(sensor)
		if state:
			color_state[0]=state # Обновление состояния цвета.
			change_sensor_color(sensor, state) # Изменение цвета датчика.
	return color_state

# Функция `change_sensor_color()` изменяет цвет детали датчика в зависимости от полученного цвета.
# Если цвет предоставлен, то свойство `albedo_color` материала детали датчика устанавливается в указанный цвет.
func change_sensor_color(sensor, color):
	if color:
		sensor.get_child(0).get("material_override").set("albedo_color",color)
	pass

# Функция `get_sensor_color()` определяет цвет обнаруженного объекта.
# Если датчик сталкивается с объектом, у которого есть метод `_get_color()`, то возвращается этот цвет.
# В противном случае возвращается `null`.
func get_sensor_color(sensor):
	if sensor.is_colliding():
		var col = sensor.get_collider()
		if col and col.has_method("_get_color"):
				return col._get_color()
	return null
