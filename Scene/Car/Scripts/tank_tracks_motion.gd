extends RigidBody3D

class_name TankTracksMotion
@onready var mesh = $Mesh

const MAX_SPEED = 5.0
const ACCELERATION = 20.0
const DECELERATION = 10.0
const TURN_SPEED = 0.2

var leftTrackSpeedPercent = 0
var rightTrackSpeedPercent = 0

var movement_degrees = 0.0

func set_direction_in_degrees(degrees):
	# Normalize degrees to be within 0 to 360
	movement_degrees = fmod(degrees, 360.0)
	if movement_degrees < 0:
		movement_degrees += 360.0

func _process(_delta):
	var leftTrackSpeed = MAX_SPEED * (leftTrackSpeedPercent / 100.0) * 2.0
	var rightTrackSpeed = MAX_SPEED * (rightTrackSpeedPercent / 100.0) * 2.0
	var direction_rad = deg_to_rad(movement_degrees)
	
	# Calculate forward and right vectors based on the degrees
	var forward = Vector3(cos(direction_rad), 0, sin(direction_rad))
	
	# Calculate linear velocity based on the track speeds and direction
	var average_speed = (leftTrackSpeed + rightTrackSpeed) * 0.5
	var linear_velocities = forward * average_speed
	
	# Adjust linear velocity direction based on the angle
	if movement_degrees == 0:
		linear_velocities = transform.basis.z.normalized() * average_speed
	elif movement_degrees == 180:
		linear_velocities = -transform.basis.z.normalized() * average_speed
	elif movement_degrees == 90:
		linear_velocities = transform.basis.x.normalized() * average_speed
	elif movement_degrees == 270:
		linear_velocities = -transform.basis.x.normalized() * average_speed
	
	set_linear_velocity(-linear_velocities)
	
	# Calculate angular velocity
	var angular_velocities = (rightTrackSpeed - leftTrackSpeed) * TURN_SPEED
	set_angular_velocity(Vector3(0, angular_velocities, 0))

func set_left_track_speed_percent(percent):
	leftTrackSpeedPercent = clamp(percent, -200, 200)

func set_right_track_speed_percent(percent):
	rightTrackSpeedPercent = clamp(percent, -200, 200)

func get_speedL():
	return leftTrackSpeedPercent
	
func get_speedR():
	return rightTrackSpeedPercent
