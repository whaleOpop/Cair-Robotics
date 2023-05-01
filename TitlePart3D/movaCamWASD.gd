extends Camera3D



var speed = 10
#var height = 20*100
var velocity = Vector3(0,20*20,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var cast = $"../RayCast3D"
@onready var camera = $"."
# Called every frame. 'delta' is the elapsed time since the previous frame.
var _newdelta = 0.0
var mouseDelat = Vector3()
func _process(delta):
	_newdelta=delta
	

		
	velocity=get_input(velocity)
	self.position=velocity*delta

	pass
var posmouse = Vector3()
var state = String()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:

		var mouse_pos = get_viewport().get_mouse_position()
		var space_state = get_world_3d().direct_space_state
		var params= PhysicsRayQueryParameters3D.new()
		params.from = camera.project_ray_origin(mouse_pos)
		params.to = params.from + camera.project_ray_normal(mouse_pos) * camera.get_far()
		var result = space_state.intersect_ray(params)
		if not result.is_empty():
			state = result.collider._on_interact()
			
			print(result)
			
			
			
	
		#posmouse = result.get("position")
		#if posmouse!= null:
			#posmouse.x+=2
			#posmouse.z-=2
			#posmouse.y=5
			#cast.target_position=posmouse
			#cast.position=posmouse
	pass

#
##
#var obj = Node3D
#var obj_position = Vector3()
#func _input(event):
#	var collided_object=null
#	var state = null
#	if event is InputEventMouseButton :
#		if collided_object!=null:
#			if state!=null:
#
#				pass
#	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#		if self.is_colliding():
#			if self.get_collider() :
#				collided_object = self.get_collider()
#				state = collided_object._on_interact()
#
#		if state == "down":
#			obj.position.z+=4
#		if state == "up":
#			obj.position.z-=4
#		if state == "right":
#			obj.position.x+=4
#		if state == "left":
#			obj.position.x-=4
#		if state == "delete":
#			collided_object.get_parent().get_parent().get_parent().queue_free()
#		if state == "rotate":
#			obj.rotation_degrees.y+=90
#
#
#		if state == "cell":
#			obj=collided_object.get_parent().get_parent()
#		state=null
#
#
#
#
#
#
#
#	pass
##
#*/
func get_input(velocity):
	
	
	if Input.is_action_pressed("right"):
		velocity.x += 1*speed
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1*speed
		
	if Input.is_action_pressed("down"):
		velocity.z += 1*speed
		
	if Input.is_action_pressed("up"):
		velocity.z -= 1*speed

	if Input.is_action_just_released("zoomUp"):
		velocity.y-=1*speed		
	
	if Input.is_action_just_released("zoomDown"):
		velocity.y+=1*speed	
	
	return velocity

