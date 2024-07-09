extends RigidBody3D

class_name tank_tracks_motion

const MAX_SPEED = 5.0
const ACCELERATION = 20.0
const DECELERATION = 10.0
const TURN_SPEED = 0.2  # Коэффициент скорости поворота (можно настроить)

var leftTrackSpeedPercent = 0
var rightTrackSpeedPercent = 0

func _process(delta):
	var leftTrackSpeed = MAX_SPEED * (leftTrackSpeedPercent / 100.0) * 2.0
	var rightTrackSpeed = MAX_SPEED * (rightTrackSpeedPercent / 100.0) * 2.0
	
	var linear_velocity = transform.basis.x.normalized() * (rightTrackSpeed + leftTrackSpeed) * 0.5
	set_linear_velocity(linear_velocity)
	
	var angular_velocity = (rightTrackSpeed - leftTrackSpeed) * TURN_SPEED
	set_angular_velocity(Vector3(0, angular_velocity, 0))


func set_left_track_speed_percent(percent):
	leftTrackSpeedPercent = clamp(percent, -200, 200)

func set_right_track_speed_percent(percent):
	rightTrackSpeedPercent = clamp(percent, -200, 200)

