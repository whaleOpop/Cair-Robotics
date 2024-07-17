extends Node3D

class_name UltraSonicSensor

var sensors: Array[RayCast3D] = []

func _ready():
	for child in get_children():
		if child is RayCast3D:
			sensors.append(child)

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
