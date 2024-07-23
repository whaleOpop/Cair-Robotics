extends Node3D

class_name UltraSonicSensor
# Класс `UltraSonicSensor` наследуется от `Node3D` и предназначен для использования в качестве ультразвукового датчика в игровом движке Godot Engine.
# Ультразвуковой датчик позволяет измерять расстояния до объектов в окружающей среде.

# Список датчиков (`RayCast3D`) используется для хранения всех дочерних узлов, которые являются датчиками ультразвука.
var sensors: Array[RayCast3D] = []

# Функция `_ready()` вызывается при инициализации узла.
# Она проходит через все дочерние узлы и добавляет те из них, которые являются экземплярами `RayCast3D`, в список датчиков.
func _ready():
	for child in get_children():
		if child is RayCast3D:
			sensors.append(child)

# Функция `get_distances()` возвращает массив расстояний до ближайших объектов от каждого датчика.
# Для каждого датчика, если он сталкивается с объектом, рассчитывается расстояние до точки столкновения.
# Если датчик не сталкивается с объектом, возвращается значение 100, что может быть интерпретировано как "необнаружено" или "максимально возможное расстояние".
func get_distances() -> Array[float]:
	var distances: Array[float] = []
	for sensor in sensors:
		if sensor.is_colliding():
			var collision_point = sensor.get_collision_point()
			var distance = sensor.global_transform.origin.distance_to(collision_point)
			distances.append(distance)
		else:
			distances.append(100)
	return distances
