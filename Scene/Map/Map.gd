"""
Краткое описание:
Этот скрипт отвечает за работу с картами в игре. Он использует библиотеку Godot Engine для работы с
3D-объектами и JSON для сохранения и загрузки данных. Скрипт содержит различные элементы, такие как 
направленная линия, поворот, цвета, финиш, контрольные точки и квадраты, которые пользователь может 
выбирать из списка и добавлять на карту. Кроме того, скрипт позволяет сохранять и загружать созданные 
пользователем карты. В программе также есть возможность управления автомобилем на карте, который можно
добавить на карту и настроить параметры движения. Скрипт также содержит функции для изменения порядка
элементов на карте и удаления шагов из списка действий."""

extends CanvasLayer



@export var btnState =preload("res://Scene/Map/2d/stButton/StatmentButton.tscn")
@export var AreaRemove = preload("res://Scene/ConstructMap/3d/mapParts/Area3dRemove/area_3d_remove.tscn")

@onready var amimUI = $AnimationPlayer
@onready var MapLoader = $Node3D/SubViewportContainer/SubViewport/MapLoader
@onready var btnPlay =$Node3D/Panel2/Panel/TextureRect3/HBoxContainer/Control/Play
@onready var btnSpeed = $Node3D/Panel2/Speed
@onready var btnRotation =$Node3D/Panel2/Rotation
@onready var btnTime =$Node3D/Panel2/time
@onready var btnLed =$Node3D/Panel2/led
@onready var btnDuration  =$Node3D/Panel2/duration
@onready var btnColor=$Node3D/Panel2/ColorSensor
@onready var btnLin=$Node3D/Panel2/Line
@onready var btnUltra=$Node3D/Panel2/UltraSonnic
@onready var visualStatmentlist = $Node3D/Panel2/Panel/ScrollContainer/VBoxContainer


var secconds = 0
var minutos=0
func hideControl():
	btnSpeed.hide()
	btnRotation.hide()
	btnTime.hide()
	btnLed.hide()
	btnDuration.hide()
	btnColor.hide()
	btnLin.hide()
	btnUltra.hide()
	pass

func showControl():
	btnSpeed.show()
	btnRotation.show()
	btnTime.show()
	btnLed.show()
	btnDuration.show()
	btnColor.show()
	btnLin.show()
	btnUltra.show()
	pass

func _ready():
	MapLoader.add_child(AreaRemove.instantiate())
	btnPlay.disabled=true
	hideControl()

	pass # Replace with function body.


func _on_button_pressed():
	for i in MapLoader.get_children():
		if i.get("metadata/Name") =="Car":
			i.queue_free()
	$Node3D/Panel2.show()
	$Node3D/btnRestart.hide()
	$Seconds.stop()
	Globals.Succesfull=false
	$Seconds.autostart=false
	secconds=0
	minutos=0
	Globals.Checkpoint=0
	$Node3D/Panel3/TextureRect/TimeRace.text="00 : 00"
	for i in $Node3D/SubViewportContainer/SubViewport/MapLoader.get_children():
		if i.has_method("reset"):
			i.reset()
			
	pass # Replace with function body.

func _process(delta):
	$Node3D/Panel3/TextureRect/Result.text=var_to_str(Globals.Checkpoint)
	if Globals.Succesfull==true:
		$Seconds.stop()
		$Seconds.autostart=false
		$Node3D/Panel4/Time.text=$Node3D/Panel3/TextureRect/TimeRace.text
		$Node3D/Panel4/Label2.text=$Node3D/Panel3/TextureRect/Result.text
		$Node3D/Panel4.show()
	pass

func _on_button_toggled(button_pressed):
	if button_pressed:
		amimUI.play("line_btn")
	else:
		amimUI.play_backwards("line_btn")
	pass # Replace with function body.


func _on_ultra_sonnic_toggled(button_pressed):
	if button_pressed:
		amimUI.play("ultra_btn")
	else:
		amimUI.play_backwards("ultra_btn")
	pass # Replace with function body.


func _on_color_sensor_toggled(button_pressed):
	if button_pressed:
		amimUI.play("color_btn")
	else:
		amimUI.play_backwards("color_btn")
	pass # Replace with function body.


func _on_duration_toggled(button_pressed):
	print("dskdsj")
	if button_pressed:
		amimUI.play("dur_btn")
	else:
		amimUI.play_backwards("dur_btn")
	pass # Replace with function body.

var dur_flag = true
func _on_duration_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if dur_flag:
				amimUI.play("dur_btn")
				dur_flag=!dur_flag
			else:
				amimUI.play_backwards("dur_btn")
				dur_flag=!dur_flag
	pass # Replace with function body.



var led_flag = true
func _on_led_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if led_flag:
				amimUI.play("let_btn")
				led_flag=!led_flag
			else:
				amimUI.play_backwards("let_btn")
				led_flag=!led_flag
	pass # Replace with function body.


var time_flag = true
func _on_time_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed: 
			if time_flag:
				amimUI.play("time_btn")
				time_flag=!time_flag
			else:
				amimUI.play_backwards("time_btn")
				time_flag=!time_flag
	pass # Replace with function body.


func _on_rotation_toggled(button_pressed):
	if button_pressed:
		amimUI.play("rotation_btn")
	else:
		amimUI.play_backwards("rotation_btn")
	pass # Replace with function body.


func _on_speed_toggled(button_pressed):
	if button_pressed:
		amimUI.play("speed_btn")
	else:
		amimUI.play_backwards("speed_btn")
	pass # Replace with function body.


func _on_plus_pressed():
	$Node3D/Panel.show()
	pass # Replace with function body.


func _on_cancel_pressed():
	$Node3D/Panel.hide()
	$Node3D/Panel/TextureRect/LineEdit.text=""
	$Node3D/Panel/TextureRect/Label.text=""
	pass # Replace with function body.


var button_group = ButtonGroup.new()

func _on_ok_pressed():
	var stName = $Node3D/Panel/TextureRect/LineEdit
	if stName.text!="":
		if Globals.isStateUseName(stName.text):
			var stat = btnState.instantiate()
			stat.setName(stName.text)
			$Node3D/Panel2/Panel/ScrollContainer/VBoxContainer.add_child(stat)
			stat.get_child(0).connect("pressed",getCurrentState)
			stat.get_child(0).set("button_group",button_group)
			
			for i in button_group.get_buttons():
				i.connect("pressed",getCurrentState)
			$Node3D/Panel.hide()
			$Node3D/Panel2/Panel/CurStatment.text=stName.text
			Globals.CurrentStatment=Globals.getStateByName(stName.text)
			$Node3D/Panel/TextureRect/LineEdit.text=""
			$Node3D/Panel/TextureRect/Label.text=""
		else:
			$Node3D/Panel/TextureRect/Label.text="Шаг с этим названием уже существует"
	else:
		$Node3D/Panel/TextureRect/Label.text="Введите название шага"
		
	pass # Replace with function body.


func getCurrentState():
	$Node3D/Panel2/Panel/CurStatment.text=button_group.get_pressed_button().get_child(0).text
	Globals.CurrentStatment=Globals.getStateByName(button_group.get_pressed_button().get_child(0).text)
	$Node3D/Panel2/Line/LineSensor.setLineByState()
	$Node3D/Panel2/UltraSonnic/ultrasonic.setUltraSonicByState()
	$Node3D/Panel2/ColorSensor/colorsensor.setColorByState()
	$Node3D/Panel2/Speed/speed.setSpeedByState()
	$Node3D/Panel2/Rotation/rotation.setRotationByState()
	$Node3D/Panel2/duration.setDurationByState()
	$Node3D/Panel2/led.setLedByState()
	$Node3D/Panel2/time.setTimeByState()
	pass


	


func _on_minus_pressed():
	var list = $Node3D/Panel2/Panel/ScrollContainer/VBoxContainer.get_children()
	for i in list:
		if i.get_child(0).get_child(0).text==$Node3D/Panel2/Panel/CurStatment.text:
			i.queue_free()
			Globals.deleteState()
	
	print(Globals.statmentList)
	$Node3D/Panel2/Panel/CurStatment.text="Deleted"
	Globals.CurrentStatment=null
	pass # Replace with function body.

@onready var Car = preload("res://Scene/Car/Car.tscn")

func _on_play_pressed():

	if isCarOnMap(MapLoader):
		var car = Car.instantiate() 
		
		car.set("position",Globals.RobotPos[0])
		car.set("rotation_degrees",Globals.RobotRot[0])
		car.rotation_degrees.y+=0

		$Seconds.autostart=true
		$Seconds.start()
		MapLoader.add_child(car)
		$Node3D/Panel2.hide()
		$Node3D/btnRestart.show()
	else:
		

		$Seconds.stop()
		
		$Seconds.autostart=true
		$Node3D/Panel2.show()
		$Node3D/btnRestart.hide()
	
	pass # Replace with function body.
func isCarOnMap(listpartmap):
	for i in listpartmap.get_children():
		if i.get("metadata/Name") =="Car":
			return false
	return true


func _on_v_box_container_child_entered_tree(node):
	btnPlay.disabled=false
	showControl()
		
	pass # Replace with function body.


func _on_v_box_container_child_exiting_tree(node):
	if Globals.statmentList.size()==0:
		btnPlay.disabled=true
		hideControl()
		for i in MapLoader.get_children():
			if i.get("metadata/Name") =="Car":
				i.queue_free()
				
	pass # Replace with function body.


func _on_up_pressed():
	if Globals.CurrentStatment!=0:
		var item = visualStatmentlist.get_child(Globals.CurrentStatment)
		var itemswap = visualStatmentlist.get_child(Globals.CurrentStatment-1)	
		visualStatmentlist.move_child(visualStatmentlist.get_child(Globals.CurrentStatment),Globals.CurrentStatment-1)
	
		var itemId = Globals.statmentList[Globals.CurrentStatment]
		Globals.statmentList[Globals.CurrentStatment]=Globals.statmentList[Globals.CurrentStatment-1]
		Globals.statmentList[Globals.CurrentStatment-1]=itemId
	pass # Replace with function body.


func _on_down_pressed():
	if Globals.CurrentStatment!=Globals.statmentList.size()-1:
		var item = visualStatmentlist.get_child(Globals.CurrentStatment)
		var itemswap = visualStatmentlist.get_child(Globals.CurrentStatment+1)	
		visualStatmentlist.move_child(visualStatmentlist.get_child(Globals.CurrentStatment),Globals.CurrentStatment+1)
		var itemId = Globals.statmentList[Globals.CurrentStatment]
		Globals.statmentList[Globals.CurrentStatment]=Globals.statmentList[Globals.CurrentStatment+1]
		Globals.statmentList[Globals.CurrentStatment-1]=itemId
	pass # Replace with function body.

	
var MainScene = load("res://Scene/Menu/Main.tscn")
func _on_btn_back_pressed():
	Globals.CurrentStatment=null
	Globals.statmentList=[]
	queue_free()
	get_tree().change_scene_to_packed(MainScene)
	
	pass # Replace with function body.



func _on_seconds_timeout():
	secconds=secconds+1
	
	print(secconds)
	if (secconds%60==0):
		minutos=secconds/60
	if (secconds==60):
		secconds=0
	
	$Node3D/Panel3/TextureRect/TimeRace.text=var_to_str(minutos).pad_zeros(2)+" : "+var_to_str(secconds).pad_zeros(2)
	
	pass # Replace with function body.



func _on_ok_suck_pressed():
	Globals.Succesfull=false
	$Node3D/Panel4.hide()

	pass # Replace with function body.
