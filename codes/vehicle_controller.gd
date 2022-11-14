extends VehicleBody

onready var ui = get_node("/root/AutoLoad")
onready var LRAY1 : RayCast = $LRay1
onready var LRAY2 : RayCast = $LRay2
onready var LRAY3 : RayCast = $LRay3
onready var RRAY1 : RayCast = $RRay1
onready var RRAY2 : RayCast = $RRay2
onready var RRAY3 : RayCast = $RRay3

func _process(delta):
	if LRAY1.is_colliding():
		ui.l1=1
	else:
		ui.l1=0
	
	if LRAY2.is_colliding():
		ui.l2=1
	else:
		ui.l2=0
		
	if LRAY3.is_colliding():
		ui.l3=1
	else:
		ui.l3=0
		
	if RRAY3.is_colliding():
		ui.r3=1
	else:
		ui.r3=0
		
	if RRAY2.is_colliding():
		ui.r2=1
	else:
		ui.r2=0
	
	if RRAY1.is_colliding():
		ui.r1=1
	else:
		ui.r1=0
		
	if (ui.moveFlag_get()=="Left"):
		$LWheelBack.engine_force=200;
		$LWheelForw.engine_force=200;
		$RWheelBack.engine_force=-200;
		$RWheelForw.engine_force=-200;
	elif (ui.moveFlag_get()=="Right"):
		$LWheelBack.engine_force=-200;
		$LWheelForw.engine_force=-200;
		$RWheelBack.engine_force=200;
		$RWheelForw.engine_force=200;
	elif (ui.moveFlag_get()=="Stop"):
		$LWheelBack.engine_force=0;
		$LWheelForw.engine_force=0;
		$RWheelBack.engine_force=0;
		$RWheelForw.engine_force=0;
	pass
