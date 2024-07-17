extends CanvasLayer

@export var MainScene = load("res://Scene/Menu/Main.tscn")

@export var btnState: PackedScene =preload("res://Scene/Map/2d/stButton/StatmentButton.tscn")
@export var AreaRemove = preload("res://Scene/ConstructMap/3d/mapParts/Area3dRemove/area_3d_remove.tscn")
@export var Buttons = preload("res://Scene/PopupMenu/popupMenu/btnEmpty/buttonEmpty.tscn")

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
@onready var projects_list_panel = $Node3D/projects_list_panel 
@onready var vbox_projects_list = $Node3D/projects_list_panel/TextureRect/ScrollContainer/vbox_projects_list
@onready var add_st_error_load_label = $Node3D/projects_list_panel/TextureRect/add_st_error_load_label

@onready var project_save_panel = $Node3D/project_save_panel
@onready var project_error_save_label = $Node3D/project_save_panel/TextureRect/project_error_save_label
@onready var text_edit_save = $Node3D/project_save_panel/TextureRect/text_edit_save

@onready var Car = preload("res://Scene/Car/Car.tscn")

var secconds = 0
var minutos = 0
var dur_flag = true
var led_flag = true
var time_flag = true
var btn_group = ButtonGroup.new()
var loadname

func hide_control():
	speed_btn.hide()
	rotation_xyz_btn.hide()
	timer_btn.hide()
	led_btn.hide()
	duration_btn.hide()
	color_sensor_btn.hide()
	line_btn.hide()
	ultra_sonic_btn.hide()

func show_control():
	speed_btn.show()
	rotation_xyz_btn.hide()
	timer_btn.show()
	led_btn.show()
	duration_btn.show()
	color_sensor_btn.show()
	line_btn.show()
	ultra_sonic_btn.show()

func _ready():
	map_loader.add_child(AreaRemove.instantiate())
	play_btn.disabled = true
	hide_control()

func _save(filename: String) -> void:
	var dir = DirAccess.open("user://")
	dir.make_dir("projects")   
	var save_file = FileAccess.open("user://projects/" + filename + ".cair", FileAccess.WRITE)
	for i in Globals.statmentList:
		save_file.store_line(JSON.stringify(i.to_dict()))
	save_file.close()

func _load(filename: String) -> void:
	var dir = DirAccess.open("user://")
	dir.make_dir("projects")
	if filename == "":
		print("Error, filename is empty.")
		return
	var file_path = "user://projects/" + filename
	if not FileAccess.file_exists(file_path):
		print("Error, no Save File to load.")
		return
	var save_file = FileAccess.open(file_path, FileAccess.READ)
	if save_file == null:
		print("Error, could not open Save File.")
		return
	Globals.statmentList.clear()
	while save_file.get_position() < save_file.get_length():
		var line = save_file.get_line().strip_edges()
		if line.is_empty():
			continue
		var json = JSON.new()
		var err = json.parse(line)
		if err != OK:
			print("Error parsing JSON: ", line)
			continue
		var data: Dictionary = json.data
		if data == null:
			print("Error: parsed JSON data is null.")
			continue
		Globals.statmentList.append(Statment.from_dict(data))
	save_file.close()
	Globals.CurrentStatment=0
	for i in Globals.statmentList:
		_add_button(i.stName)
	
	current_statment.text=Globals.getStateById(Globals.CurrentStatment)
	
		
	print("Loading complete.")
func _add_button(name: String) -> void:
	var stat = btnState.instantiate()
	stat.name=name
	stat.loadName(name)
	statement_list.add_child(stat)
	var button = stat.get_child(0)
	button.set("button_group", button_group)
	
	for i in button_group.get_buttons():
		if not i.is_connected("pressed", getCurrentState):
			i.connect("pressed", getCurrentState)
	

func _on_button_pressed():
	for i in map_loader.get_children():
		if i.get("metadata/Name") == "Car":
			i.queue_free()
	show_control()
	debug_panel.hide()
	timer_seconds.stop()
	timer_seconds.autostart = false
	Globals.Succesfull = false
	secconds = 0
	minutos = 0
	Globals.Checkpoint = 0
	time_race.text = "00 : 00"
	for i in map_loader.get_children():
		if i.has_method("reset"):
			i.reset()

func _process(_delta):
	count_checkpoint.text = var_to_str(Globals.Checkpoint)
	if Globals.Succesfull:
		timer_seconds.stop()
		timer_seconds.autostart = false
		count_checkpoint_result.text = count_checkpoint.text
		result_panel.show()

func _on_button_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("line_btn")
	else:
		amim_ui.play_backwards("line_btn")

func _on_ultra_sonic_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("ultra_btn")
	else:
		amim_ui.play_backwards("ultra_btn")

func _on_color_sensor_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("color_btn")
	else:
		amim_ui.play_backwards("color_btn")

func _on_duration_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("dur_btn")
	else:
		amim_ui.play_backwards("dur_btn")

func _on_duration_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if dur_flag:
			amim_ui.play("dur_btn")
		else:
			amim_ui.play_backwards("dur_btn")
		dur_flag = !dur_flag

func _on_led_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if led_flag:
			amim_ui.play("let_btn")
		else:
			amim_ui.play_backwards("let_btn")
		led_flag = !led_flag

func _on_time_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if time_flag:
			amim_ui.play("time_btn")
		else:
			amim_ui.play_backwards("time_btn")
		time_flag = !time_flag

func _on_rotation_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("rotation_btn")
	else:
		amim_ui.play_backwards("rotation_btn")

func _on_speed_toggled(button_pressed):
	if button_pressed:
		amim_ui.play("speed_btn")
	else:
		amim_ui.play_backwards("speed_btn")

func _on_plus_pressed():
	add_statment_panel.show()

func _on_cancel_pressed():
	add_statment_panel.hide()
	name_st_edit.text = ""
	add_st_error_label.text = ""
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
	for i in statement_list.get_children():
		if i.get_child(0).get_child(0).text == current_statment.text:
			i.queue_free()
			Globals.deleteState()
	current_statment.text = "Deleted"
	Globals.CurrentStatment = null

func _on_play_pressed():
	if is_car_on_map(map_loader):
		var car = Car.instantiate()
		car.set("position", Globals.RobotPos[0])
		car.set("rotation_degrees", Globals.RobotRot[0])
		timer_seconds.autostart = true
		timer_seconds.start()
		map_loader.add_child(car)
		debug_panel.show()
		hide_control()
	else:
		timer_seconds.stop()
		timer_seconds.autostart = true
		robot_control_back.show()
		restart_btn.hide()
		debug_panel.hide()
		show_control()

func is_car_on_map(listpartmap):
	for i in listpartmap.get_children():
		if i.get("metadata/Name") == "Car":
			return false
	return true

func _on_v_box_container_child_entered_tree(_node):
	play_btn.disabled = false
	show_control()

func _on_v_box_container_child_exiting_tree(_node):
	if Globals.statmentList.size() == 0:
		play_btn.disabled = true
		hide_control()
		for i in map_loader.get_children():
			if i.get("metadata/Name") == "Car":
				i.queue_free()

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

func _on_btn_back_pressed():
	Globals.CurrentStatment = null
	Globals.statmentList.clear()
	queue_free()
	get_tree().change_scene_to_packed(MainScene)

func _on_seconds_timeout():
	secconds += 1
	if secconds >= 60:
		@warning_ignore("integer_division")
		minutos = secconds / 60
		secconds = secconds % 60
	time_race.text = str(minutos).pad_zeros(2) + " : " + str(secconds).pad_zeros(2)

func _on_ok_suck_pressed():
	Globals.Succesfull = false
	result_panel.hide()

func _on_save_btn_pressed():
	project_error_save_label.text=""
	text_edit_save.text=""
	project_save_panel.show()
func get_map_files():
	var files = []
	var dir = DirAccess.open("user://projects")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		if not file.begins_with(".") and file.get_extension() == "cair":
			files.append(file)
	dir.list_dir_end()
	return files

func _on_load_btn_pressed():
	projects_list_panel.show()
	var maps_name = get_map_files()
	var buttons
	for i in maps_name:
		buttons = Buttons.instantiate()
		buttons.get_child(0).text = i
		buttons.get_child(0).set("button_group", btn_group)
		vbox_projects_list.add_child(buttons)
	for i in btn_group.get_buttons():
		i.connect("pressed", get_state_name)

func get_state_name():
	loadname = btn_group.get_pressed_button().text

func _on_ok_load_pressed():
	if loadname:
		projects_list_panel.hide()
		_load(loadname)
		for i in vbox_projects_list.get_children():
			i.queue_free()
		loadname = null
	else:
		add_st_error_load_label.text = "Вы не выбрали проект"

func _on_cancel_load_pressed():
	projects_list_panel.hide()
	add_st_error_load_label.text = ""
	for i in vbox_projects_list.get_children():
		i.queue_free()


func _on_ok_save_pressed():
	if !Globals.statmentList.is_empty():
		if text_edit_save.text!="":
			_save(text_edit_save.text)
			project_save_panel.hide()
		else:
			project_error_save_label.text="Введите название проекта"
	else:
		project_error_save_label.text="Вы не можете сохранить пустой проект"
	
	pass # Replace with function body.


func _on_cancel_save_pressed():
	project_save_panel.hide()
	project_error_save_label.text=""
	text_edit_save.text=""
	pass # Replace with function body.
