extends VehicleBody

onready var ui = get_node("/root/AutoLoad")
onready var LRAY1 : RayCast = $LRay1
onready var LRAY2 : RayCast = $LRay2
onready var LRAY3 : RayCast = $LRay3
onready var RRAY1 : RayCast = $RRay1
onready var RRAY2 : RayCast = $RRay2
onready var RRAY3 : RayCast = $RRay3

onready var LWheelBac :VehicleWheel = $LWheelBac 
onready var LWheelFor :VehicleWheel = $LWheelFor 
onready var RWheelBac :VehicleWheel = $RWheelBac 
onready var RWheelFor :VehicleWheel = $RWheelFor 

func _process(_delta):

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
		LWheelBac.engine_force=500;
		LWheelFor.engine_force=500;
		RWheelBac.engine_force=-500;
		RWheelFor.engine_force=-500;
	elif (ui.moveFlag_get()=="Right"):
		LWheelBac.engine_force=-500;
		LWheelFor.engine_force=-500;
		RWheelBac.engine_force=500;
		RWheelFor.engine_force=500;
	elif (ui.moveFlag_get()=="Stop"):
		LWheelBac.engine_force=0;
		LWheelFor.engine_force=0;
		RWheelBac.engine_force=0;
		RWheelFor.engine_force=0;
	pass
