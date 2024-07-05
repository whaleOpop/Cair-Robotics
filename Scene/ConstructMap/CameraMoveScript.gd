extends Node3D

# Parameters
@export var speed: float = 10.0
@export var ControlMove: PackedScene = preload("res://Scene/ConstructMap/3d/3dUiParts/ControlMove.tscn")
@export var boundary_min: Vector3 = Vector3(-20, 7, -20)
@export var boundary_max: Vector3 = Vector3(20, 30, 20)

# Variables
var velocity: Vector3 = Vector3.ZERO
var _newdelta: float = 0.0
var target_position: Vector3 = Vector3(0, 20, 0)
var acceleration: float = 10.0
var damping: float = 0.1
var posmouse: Vector3 = Vector3()
var state: String = ""
var obj: Node = null
var lastobj: Node = null
var objPress: bool = false
var lastObjPress: bool = false

@onready var camera: Camera3D = get_viewport().get_camera_3d()

func _ready():
	camera.position.y = 0

func _process(delta: float) -> void:
	
	_newdelta = delta
	target_position = get_input(target_position, delta)
	velocity = velocity.lerp(target_position - position, damping)
	position += velocity * delta
	
	# Clamp position to boundaries
	position.x = clamp(position.x, boundary_min.x, boundary_max.x)
	position.y = clamp(position.y, boundary_min.y, boundary_max.y)
	position.z = clamp(position.z, boundary_min.z, boundary_max.z)

func raycast(from: Vector3, to: Vector3, exclude: Array = []) -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	if space_state == null:
		print("Physics server is not available.")
		return {}
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.exclude = exclude
	return space_state.intersect_ray(query)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		call_deferred("_perform_raycast")

func _perform_raycast() -> void:
	var ray_length: float = 1000.0
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * ray_length
	var result = raycast(ray_origin, ray_end)
	if not result.is_empty():
		var collider = result.collider
		if collider and collider.has_method("_on_interact"):
			state = collider._on_interact()
			handle_interaction(state, collider)

func handle_interaction(state: String, collider: Node) -> void:
	match state:
		"delete":
			if obj:
				disconnect_signals(obj)
				obj.queue_free()
				obj = null
				return
		"down":
			if obj:
				obj.position.z += 4
		"left":
			if obj:
				obj.position.x -= 4
		"right":
			if obj:
				obj.position.x += 4
		"up":
			if obj:
				obj.position.z -= 4
		"rotate":
			if obj:
				obj.rotation_degrees.y += 90
		"cell":
			connect_signals(collider)
			if is_instance_valid(lastobj) and lastobj != obj:
				disconnect_signals(lastobj)
				var control_move_node = lastobj.get_node_or_null("ControlMove")
				if control_move_node:
					control_move_node.queue_free()
			lastobj = obj

func connect_signals(node: Node) -> void:
	if node and not node.is_queued_for_deletion():
		if not node.is_connected("cell_pressed", _on_cell_pressed):
			node.connect("cell_pressed", _on_cell_pressed)
		if not node.is_connected("obj_link",_on_obj_link):
			node.connect("obj_link",_on_obj_link)

func disconnect_signals(node: Node) -> void:
	if node and not node.is_queued_for_deletion():
		if node.has_signal("cell_pressed") and node.is_connected("cell_pressed", _on_cell_pressed):
			node.disconnect("cell_pressed", _on_cell_pressed)
		if node.has_signal("obj_link") and node.is_connected("obj_link",_on_obj_link):
			node.disconnect("obj_link",_on_obj_link)

func _on_cell_pressed(isPressed: bool) -> void:
	ui_view(isPressed)

func _on_obj_link(link_obj: Node) -> void:
	get_obj(link_obj)

func ui_view(isPressed: bool) -> void:
	if obj and not obj.is_queued_for_deletion():
		var ui = ControlMove.instantiate()
		if not isPressed:
			ui.position.y = 1
			ui.rotation = -obj.rotation
			obj.add_child(ui)
		else:
			var control_move_node = obj.get_node_or_null("ControlMove")
			if control_move_node:
				control_move_node.queue_free()

func get_obj(link_obj: Node) -> void:
	if link_obj and not link_obj.is_queued_for_deletion():
		obj = link_obj

func obj_press(isPressed: bool) -> void:
	objPress = isPressed

func lastobj_press(isPressed: bool) -> void:
	lastObjPress = isPressed

func get_input(_position: Vector3, delta: float) -> Vector3:
	if Input.is_action_pressed("right"):
		_position.x += acceleration * delta
	elif Input.is_action_pressed("left"):
		_position.x -= acceleration * delta
	if Input.is_action_pressed("down"):
		_position.z += acceleration * delta
	elif Input.is_action_pressed("up"):
		_position.z -= acceleration * delta
	if Input.is_action_just_released("zoomUp"):
		_position.y -= acceleration * delta    
	elif Input.is_action_just_released("zoomDown"):
		_position.y += acceleration * delta
	return _position
