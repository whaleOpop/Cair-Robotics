extends CanvasLayer
"""
Краткое описание:

Это скрипт для создания карт в игре. Он использует библиотеки Godot Engine для работы с 3D-объектами
 и JSON для сохранения и загрузки данных. В программе используются различные элементы, такие как 
направленная линия, поворот, цвета, финиш, контрольные точки и квадраты. Пользователь может выбирать
 элементы из списка и добавлять их на карту, а затем сохранять и загружать свои карты."""

var MainScene = load("res://Scene/Menu/Main.tscn")

@export var Forward = preload("res://TitlePart3D/prefabMaps/parts/Forward.tscn")
@export var Rotate = preload("res://TitlePart3D/prefabMaps/parts/Rotate.tscn")
@export var Colors = preload("res://TitlePart3D/prefabMaps/parts/Color.tscn")
@export var Finish = preload("res://TitlePart3D/prefabMaps/parts/Finish.tscn")
@export var CheckPoint = preload("res://TitlePart3D/prefabMaps/parts/Checkpoint.tscn")
@export var Square = preload( "res://TitlePart3D/prefabMaps/parts/Square.tscn")
@export var Buttons = preload("res://TitlePart2D/ConstMap/popupMenu/btnEmpty/buttonEmpty.tscn")

@onready var ConstMap = $Root3D/SubViewportContainer/SubViewport/ConstMap

@onready var btnWB = $Root3D/PanelBlur/TextureRect/TextureWB
@onready var btnRGB =$Root3D/PanelBlur/TextureRect/TextureRGB

var SelectItem = 0



signal dataListCell(list)

func _on_item_list_item_selected(index):
	SelectItem = index
		
	if SelectItem == 0:
		btnWB.visible=true
		btnRGB.visible=false
	elif SelectItem ==1:
		btnWB.visible=true
		btnRGB.visible=false
	elif SelectItem ==2:
		btnRGB.visible=true
		btnWB.visible=false
	elif SelectItem == 3:
		btnWB.visible=true
		btnRGB.visible=false
	elif SelectItem == 4:
		btnWB.visible=true
		btnRGB.visible=true
	elif SelectItem == 5:
		btnWB.visible=true
	
	
			
	print(SelectItem)
	pass # Replace with function body.



var colorPicker = Color.DARK_CYAN
var wb = null

var matWhite = StandardMaterial3D.new()
var matBlack = StandardMaterial3D.new()

@export var AreaRemove = preload("res://TitlePart3D/prefabMaps/parts/area_3d_remove.tscn")
@onready var ConstructorMap = $Root3D/SubViewportContainer/SubViewport/ConstMap
	
func _ready():
	matBlack.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matBlack.albedo_color=Color.BLACK
	ConstructorMap.add_child(AreaRemove.instantiate())
	
	matWhite.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matWhite.albedo_color=Color.WHITE
	
	pass
	
func _on_add_button_down():
	
	
	if SelectItem == 0:
	
		var forward = Forward.instantiate()
		var matLine = forward.get_child(0)
		var matSquare = forward.get_child(1)
		
		if !wb:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
		else:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(forward)
		forward.add_to_group("save");
	elif SelectItem==1:
		var rotate = Rotate.instantiate()
		var matLine = rotate.get_child(1)
		var matSquare = rotate.get_child(0)
		if !wb:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(rotate)
		rotate.add_to_group("save");
	elif SelectItem==2:
		var colors = Colors.instantiate()
		var matColor = StandardMaterial3D.new()
		var matMesh = colors.get_child(0)
		matMesh.set("surface_material_override/0",matColor)
		matColor.albedo_color=colorPicker
		matColor.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
		
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(colors)
		colors.add_to_group("save");
	elif SelectItem==3:
		var finish = Finish.instantiate()
		var matSquare = finish.get_child(0)
		var matLine = finish.get_child(1)
		if !wb:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
			
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(finish)
		finish.add_to_group("save");
	elif SelectItem==4:
		var checkPoint =CheckPoint.instantiate()
		var matLine = checkPoint.get_child(1)
		var matSquare = checkPoint.get_child(0)
		var matCheckpoint = checkPoint.get_child(2)
		var matColor = StandardMaterial3D.new()
		if !wb:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
		
		matColor.albedo_color=colorPicker
		matColor.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
		matCheckpoint.set("surface_material_override/0",matColor)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(checkPoint)
		checkPoint.add_to_group("save");
	elif SelectItem==5:
		var square= Square.instantiate()
		var matSquare = square.get_child(0)
		if !wb:
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matSquare.set("surface_material_override/0",matBlack)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(square)
		square.add_to_group("save");
	else:
		SelectItem==null

	
	
	pass # Replace with function body.


func _on_wb_toggled(button_pressed):
	wb=button_pressed
	pass # Replace with function body.


func _on_rgb_color_changed(color):
	colorPicker=color
	pass # Replace with function body.


func _on_save_button_down():
	$Root3D/PanelBlur/PanelBlur2.show()
	$Root3D/PanelBlur/PanelBlur4.show()
	pass # Replace with function body.

func _on_ok_pressed():
	print("Я нашел")
	var textedit = $Root3D/PanelBlur/PanelBlur4/TextureRect/TextEdit.text
	if textedit!="":
		_save(textedit)
	$Root3D/PanelBlur/PanelBlur2.hide()
	$Root3D/PanelBlur/PanelBlur4.hide()
	pass # Replace with function body.


func _on_cancel_pressed():
	$Root3D/PanelBlur/PanelBlur2.hide()
	$Root3D/PanelBlur/PanelBlur4.hide()
	pass # Replace with function body.


func _on_panel_hidden():
	
	pass # Replace with function body.




func _save(filename) -> void:
	var save_file = FileAccess.open("user://"+filename+".cair", FileAccess.WRITE) # Open File
	
	# Go through every object in the Sagroup
	var save_nodes = get_tree().get_nodes_in_group("save")
	for node in save_nodes:
		# Check if the node has a save function.
		if !node.has_method("saveObject"):
			print("Node '%s' is missing a save function, skipped" % node.name)
			continue
			
		# Call the node's save function.
		var node_data = node.call("saveObject")
		
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(JSON.stringify(node_data))
	
	save_file.close() # Close File
	pass
	
func _load(filename) -> void:
	# Check if the SaveFile exists
	if !filename:
		return
	if !FileAccess.file_exists("user://"+filename):
		print("Error, no Save File to load.")
		return
		
	var save_file = FileAccess.open("user://"+filename, FileAccess.READ) # Open File
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		json.parse(save_file.get_line())
		
		# Get the Data
		var node_data = json.get_data()
		
		print(node_data["nodeName"])
		if node_data["nodeName"]=="Forward":
			var forward = Forward.instantiate()
			forward.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(forward)
			forward.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Rotate":
			var rotate = Rotate.instantiate()
			rotate.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(rotate)
			rotate.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Color":
			var colors = Colors.instantiate()
			colors.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(colors)
			colors.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Checkpoint":
			var checkPoint = CheckPoint.instantiate()
			checkPoint.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(checkPoint)
			checkPoint.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
			
		elif node_data["nodeName"]=="Finish":
			var finish = Finish.instantiate()
			finish.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(finish)
			#get_node(node_data["nodeName"]).loadObject(node_data)
			finish.add_to_group("save");
		elif node_data["nodeName"]=="Square":
			var square = Square.instantiate()
			square.loadObject(node_data)
			get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(square)
			square.add_to_group("save");
		
		
	save_file.close() # Close File
	pass

var btn_group = ButtonGroup.new()
func _on_load_pressed():
	$Root3D/PanelBlur/PanelBlur2.show()
	$Root3D/PanelBlur/PanelBlur3.show()
	var mapsNAme =getMapFile() 
	var buttons 
	for i in mapsNAme:
		
		buttons = Buttons.instantiate() 
		
		buttons.get_child(0).text=i
		buttons.get_child(0).set("button_group",btn_group)
		$Root3D/PanelBlur/PanelBlur3/TextureRect/ScrollContainer/VScrollBar.add_child(buttons)
	for i in btn_group.get_buttons():
		i.connect("pressed",getName)
		
	pass # Replace with function body.

var loadname
func getName():
	
	loadname=btn_group.get_pressed_button().text
	
	pass


func _on_back_pressed():
	
	get_tree().change_scene_to_packed(MainScene)
	pass # Replace with function body.


func _on_o_kload_pressed():

	
	_load(loadname)
	#get_node(btn_group.get_pressed_button().get_path())
	$Root3D/PanelBlur/PanelBlur2.hide()
	$Root3D/PanelBlur/PanelBlur3.hide()
	var children = $Root3D/PanelBlur/PanelBlur3/TextureRect/ScrollContainer/VScrollBar.get_children()
	for i in children:
		i.queue_free()
	pass # Replace with 
	pass # Replace with function body.



func _on_cancelload_pressed():
	$Root3D/PanelBlur/PanelBlur2.hide()
	$Root3D/PanelBlur/PanelBlur3.hide()
	var children = $Root3D/PanelBlur/PanelBlur3/TextureRect/ScrollContainer/VScrollBar.get_children()
	for i in children:
		i.queue_free()
	pass # Replace with function body.
	
		
func getMapFile():
	var files = []
	var dir = DirAccess.open("user://")
	dir.list_dir_begin()

	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.get_extension()=="cair":
				files.append(file)

	dir.list_dir_end()

	return files
