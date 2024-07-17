extends CanvasLayer



@export var btnState =preload("res://Scene/Map/2d/stButton/StatmentButton.tscn")
@export var AreaRemove = preload("res://Scene/ConstructMap/3d/mapParts/Area3dRemove/area_3d_remove.tscn")

@onready var amim_ui = $amim_ui
@onready var map_loader = $Node3D/SubViewportContainer/SubViewport/map_loader

@onready var play_btn = $Node3D/robot_control_back/robot_control_front/TextureRect3/HBoxContainer/Control/play_btn

@onready var speed_btn = $Node3D/robot_control_back/speed_btn
@onready var rotation_xyz_btn = $Node3D/robot_control_back/rotation_xyz_btn
@onready var timer_btn = $Node3D/robot_control_back/timer_btn
@onready var led_btn = $Node3D/robot_control_back/led_btn
@onready var duration_btn = $Node3D/robot_control_back/duration_btn
@onready var color_sensor_btn = $Node3D/robot_control_back/color_sensor_btn
@onready var line_btn = $Node3D/robot_control_back/line_btn
@onready var ultra_sonic_btn= $Node3D/robot_control_back/ultra_sonic_btn
@onready var statement_list = $Node3D/robot_control_back/robot_control_front/ScrollContainer/statement_list
@onready var current_statment = $Node3D/robot_control_back/robot_control_front/current_statment
@onready var debug_panel = $Node3D/robot_control_back/robot_control_front/debug_panel
@onready var time_race = $Node3D/Header/TextureRect/time_race
@onready var timer_seconds = $timer_seconds
@onready var count_checkpoint = $Node3D/Header/TextureRect/count_checkpoint
@onready var count_checkpoint_result = $Node3D/result_panel/count_checkpoint_result
@onready var result_panel = $Node3D/result_panel
@onready var restart_btn = $Node3D/robot_control_back/robot_control_front/debug_panel/restart_btn
@onready var add_statment_panel = $Node3D/add_statment_panel
@onready var add_st_error_label = $Node3D/add_statment_panel/TextureRect/add_st_error_label
@onready var name_st_edit = $Node3D/add_statment_panel/TextureRect/name_st_edit

@onready var robot_control_back = $Node3D/robot_control_back
var secconds = 0
var minutos=0
var dur_flag = true
var led_flag = true

func hideControl():
	speed_btn.hide()
	rotation_xyz_btn.hide()
	timer_btn.hide()
	led_btn.hide()
	duration_btn.hide()
	color_sensor_btn.hide()
	line_btn.hide()
	ultra_sonic_btn.hide()
	pass

func showControl():
	speed_btn.show()
	rotation_xyz_btn.hide()
	timer_btn.show()
	led_btn.show()
	duration_btn.show()
	color_sensor_btn.show()
	line_btn.show()
	ultra_sonic_btn.show()
	pass

func _ready():
	map_loader.add_child(AreaRemove.instantiate())
	play_btn.disabled=true
	hideControl()

	pass # Replace with function body.


func _on_button_pressed():
	for i in map_loader.get_children():
		if i.get("metadata/Name") =="Car":
			i.queue_free()
	showControl()
	debug_panel.hide()
	timer_seconds.stop()
	timer_seconds.autostart=false
	Globals.Succesfull=false
	secconds=0
	minutos=0
	Globals.Checkpoint=0
	time_race.text="00 : 00"
	for i in map_loader.get_children():
		if i.has_method("reset"):
			i.reset()
			
	pass # Replace with function body.

func _process(_delta):
	count_checkpoint.text=var_to_str(Globals.Checkpoint)
	if Globals.Succesfull==true:
		timer_seconds.stop()
		timer_seconds.autostart=false
	
		count_checkpoint_result.text=count_checkpoint.text
		result_panel.show()
	pass

func _on_button_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("line_btn")
	else:
		amim_ui.play_backwards("line_btn")
	pass # Replace with function body.


func _on_ultra_sonnic_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("ultra_btn")
	else:
		amim_ui.play_backwards("ultra_btn")
	pass # Replace with function body.


func _on_color_sensor_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("color_btn")
	else:
		amim_ui.play_backwards("color_btn")
	pass # Replace with function body.


func _on_duration_toggled(button_pressed):
	
	if button_pressed:
		amim_ui.play("dur_btn")
	else:
		amim_ui.play_backwards("dur_btn")
	pass # Replace with function body.

func _on_duration_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if dur_flag:
				amim_ui.play("dur_btn")
				dur_flag=!dur_flag
			else:
				amim_ui.play_backwards("dur_btn")
				dur_flag=!dur_flag
	pass # Replace with function body.




func _on_led_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if led_flag:
				amim_ui.play("let_btn")
				led_flag=!led_flag
			else:
				amim_ui.play_backwards("let_btn")
				led_flag=!led_flag
	pass # Replace with function body.


var time_flag = true
func _on_time_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if time_flag:
				amim_ui.play("time_btn")
				time_flag=!time_flag
			else:
				amim_ui.play_backwards("time_btn")
				time_flag=!time_flag
	pass # Replace with function body.


func _on_rotation_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("rotation_btn")
	else:
		amim_ui.play_backwards("rotation_btn")
	pass # Replace with function body.


func _on_speed_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("speed_btn")
	else:
		amim_ui.play_backwards("speed_btn")
	pass # Replace with function body.


func _on_plus_pressed():
	add_statment_panel.show()
	pass # Replace with function body.


func _on_cancel_pressed():
	add_statment_panel.hide()
	name_st_edit.text=""
	add_st_error_label.text=""
	pass # Replace with function body.


var button_group = ButtonGroup.new()

func _on_ok_pressed():
	
	if name_st_edit.text!="":
		if Globals.isStateUseName(name_st_edit.text):
			var stat = btnState.instantiate()
			stat.setName(name_st_edit.text)
			statement_list.add_child(stat)
		
			stat.get_child(0).set("button_group",button_group)
			
			for i in button_group.get_buttons():
				if !i.is_connected("pressed",getCurrentState):
					i.connect("pressed",getCurrentState)
			add_statment_panel.hide()
			current_statment.text=name_st_edit.text
			Globals.CurrentStatment=Globals.getStateByName(name_st_edit.text)
			name_st_edit.text=""
			add_st_error_label.text=""
		else:
			add_st_error_label.text="Шаг с этим названием уже существует"
	else:
		add_st_error_label.text="Введите название шага"
		
	pass # Replace with function body.

func getCurrentState():
	current_statment.text=button_group.get_pressed_button().get_child(0).text
	Globals.CurrentStatment=Globals.getStateByName(button_group.get_pressed_button().get_child(0).text)
	line_btn.get_child(0).setLineByState()
	ultra_sonic_btn.get_child(0).setUltraSonicByState()
	color_sensor_btn.get_child(0).set_color_by_state()
	speed_btn.get_child(0).setSpeedByState()
	rotation_xyz_btn.get_child(0).setRotationByState()
	duration_btn.setDurationByState()
	led_btn.setLedByState()
	timer_btn.setTimeByState()
	pass


	


func _on_minus_pressed():
	var list = statement_list.get_children()
	for i in list:
		if i.get_child(0).get_child(0).text==current_statment.text:
			i.queue_free()
			Globals.deleteState()
	

	current_statment.text="Deleted"
	Globals.CurrentStatment=null
	pass 

@onready var Car = preload("res://Scene/Car/Car.tscn")

func _on_play_pressed():

	if isCarOnMap(map_loader):
		var car = Car.instantiate() 
		
		car.set("position",Globals.RobotPos[0])
		car.set("rotation_degrees",Globals.RobotRot[0])
		

		timer_seconds.autostart=true
		timer_seconds.start()
		map_loader.add_child(car)
		debug_panel.show()
		hideControl()
	else:

		timer_seconds.stop()
		timer_seconds.autostart=true
		robot_control_back.show()
		restart_btn.hide()
		debug_panel.hide()
		showControl()

	pass # Replace with function body.
func isCarOnMap(listpartmap):
	for i in listpartmap.get_children():
		if i.get("metadata/Name") =="Car":
			return false
	return true


func _on_v_box_container_child_entered_tree(_node):
	play_btn.disabled=false
	showControl()
		
	pass


func _on_v_box_container_child_exiting_tree(_node):
	if Globals.statmentList.size()==0:
		play_btn.disabled=true
		hideControl()
		for i in map_loader.get_children():
			if i.get("metadata/Name") =="Car":
				i.queue_free()
				
	pass


func _on_up_pressed():
	if Globals.CurrentStatment > 0:
		var current_index = Globals.CurrentStatment
		var previous_index = current_index - 1
		statement_list.move_child(current_index, previous_index)
		Globals.statmentList.swap(current_index, previous_index)
		Globals.CurrentStatment = previous_index

func _on_down_pressed():
	if Globals.CurrentStatment < Globals.statmentList.size() - 1:
		var current_index = Globals.CurrentStatment
		var next_index = current_index + 1
		statement_list.move_child(current_index, next_index)
		Globals.statmentList.swap(current_index, next_index)
		Globals.CurrentStatment = next_index

	
var MainScene = load("res://Scene/Menu/Main.tscn")
func _on_btn_back_pressed():
	Globals.CurrentStatment=null
	Globals.statmentList=[]
	queue_free()
	get_tree().change_scene_to_packed(MainScene)
	
	pass # Replace with function body.



func _on_seconds_timeout():
	# Increment seconds
	secconds += 1
	
	# Calculate minutes and handle seconds reset
	if secconds >= 60:
		@warning_ignore("integer_division")
		minutos = secconds / 60  # Use integer division
		secconds = secconds % 60  # Remainder of seconds after minutes are accounted for

	# Update the time display
	time_race.text = str(minutos).pad_zeros(2) + " : " + str(secconds).pad_zeros(2)


func _on_ok_suck_pressed():
	Globals.Succesfull=false
	result_panel.hide()
	pass # Replace with function body.
