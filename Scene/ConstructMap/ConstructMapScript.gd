extends CanvasLayer

var MainScene = load("res://Scene/Menu/Main.tscn")

@export var Forward = preload("res://Scene/ConstructMap/3d/mapParts/Forward.tscn")
@export var Rotate = preload("res://Scene/ConstructMap/3d/mapParts/Rotate.tscn")
@export var Colors = preload("res://Scene/ConstructMap/3d/mapParts/Color.tscn")
@export var Finish = preload("res://Scene/ConstructMap/3d/mapParts/Finish.tscn")
@export var CheckPoint = preload("res://Scene/ConstructMap/3d/mapParts/Checkpoint.tscn")
@export var Square = preload( "res://Scene/ConstructMap/3d/mapParts/Square.tscn")
@export var Box = preload( "res://Scene/ConstructMap/3d/mapParts/Box.tscn")
@export var Buttons = preload("res://Scene/PopupMenu/popupMenu/btnEmpty/buttonEmpty.tscn")
@export var AreaRemove = preload("res://Scene/ConstructMap/3d/mapParts/Area3dRemove/area_3d_remove.tscn")

@onready var ConstructorMap = $Root3D/SubViewportContainer/SubViewport/ConstMap
@onready var ConstMap = $Root3D/SubViewportContainer/SubViewport/ConstMap
@onready var btnWB = $Root3D/Tiles_panel/TextureRect/TextureWB
@onready var btnRGB =$Root3D/Tiles_panel/TextureRect/TextureRGB

@onready var blur_panel =$Root3D/Tiles_panel/blur_panel

@onready var load_panel =$Root3D/Tiles_panel/load_panel
@onready var load_map_list = $Root3D/Tiles_panel/load_panel/TextureRect/ScrollContainer/map_list
@onready var load_error_label = $Root3D/Tiles_panel/load_panel/TextureRect/load_error_label

@onready var save_panel =$Root3D/Tiles_panel/save_panel
@onready var save_error_label = $Root3D/Tiles_panel/save_panel/TextureRect/save_error_label
@onready var save_text_edit = $Root3D/Tiles_panel/save_panel/TextureRect/save_text_edit

var SelectItem = 0
var btn_group = ButtonGroup.new()
var loadname=""

signal dataListCell(list)

func _on_item_list_item_selected(index):
	SelectItem = index
	btnWB.visible = SelectItem in [0, 1, 3, 4, 5, 6]
	btnRGB.visible = SelectItem == 2 or SelectItem == 4



var colorPicker = Color.DARK_CYAN
var wb = null

var matWhite = StandardMaterial3D.new()
var matBlack = StandardMaterial3D.new()


	
func _ready():
	matBlack.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matBlack.albedo_color=Color.BLACK
	ConstructorMap.add_child(AreaRemove.instantiate())
	
	matWhite.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matWhite.albedo_color=Color.WHITE
	
	pass

func _on_add_button_down():
	var instance
	match SelectItem:
		0:
			instance = Forward.instantiate()
			set_materials(instance, 0, 1)
		1:
			instance = Rotate.instantiate()
			set_materials(instance, 0, 1)
		2:
			instance = Colors.instantiate()
			set_color_material(instance)
		3:
			instance = Finish.instantiate()
			set_materials(instance, 0, 1)
		4:
			instance = CheckPoint.instantiate()
			set_materials(instance, 0, 1, 2)
		5:
			instance = Square.instantiate()
			set_single_material(instance, 0)
		6:
			instance = Box.instantiate()
			set_single_material(instance, 0)
		_:
			SelectItem = null
			return

	get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(instance)
	instance.add_to_group("save")

func set_materials(instance, mat_index1, mat_index2, extra_mat_index=-1):
	var mat1 = instance.get_child(mat_index1)
	var mat2 = instance.get_child(mat_index2)
	if !wb:
		mat1.set("surface_material_override/0", matWhite)
		mat2.set("surface_material_override/0", matBlack)
	else:
		mat1.set("surface_material_override/0", matBlack)
		mat2.set("surface_material_override/0", matWhite)
	if extra_mat_index != -1:
		set_color_material(instance, extra_mat_index)

func set_single_material(instance, mat_index):
	var mat = instance.get_child(mat_index)
	if !wb:
		mat.set("surface_material_override/0", matWhite)
	else:
		mat.set("surface_material_override/0", matBlack)

func set_color_material(instance, mat_index=0):
	var matMesh = instance.get_child(mat_index)
	var matColor = StandardMaterial3D.new()
	matMesh.set("surface_material_override/0", matColor)
	matColor.albedo_color = colorPicker
	matColor.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

func _on_wb_toggled(button_pressed):
	wb=button_pressed
	pass # Replace with function body.

func _on_rgb_color_changed(color):
	colorPicker=color
	pass # Replace with function body.

func _on_save_button_down():
	blur_panel.show()
	save_panel.show()
	pass # Replace with function body.

func _on_ok_pressed():
	
	var textedit = save_text_edit.text
	
	if textedit!="":
		if _checkFinishTile():
			_save(textedit)
			blur_panel.hide()
			save_panel.hide()

			save_error_label.text=""
		else:
			save_error_label.text="Нет финиша"
			textedit=""
	else:
		save_error_label.text="Введите название карты"
		textedit=""
	
	pass # Replace with function body.
func _clearMap():
	for i in ConstMap.get_children():
		if i.get("metadata/NameCell"):
			i.queue_free()
	ConstructorMap.add_child(AreaRemove.instantiate())
	pass
func _checkFinishTile():
	for i in ConstMap.get_children():
		if i.get("metadata/NameCell"):
			if i.get("metadata/NameCell")=="Finish":
				return true
	return false

func _on_cancel_pressed():
	blur_panel.hide()
	save_panel.hide()
	save_error_label.text=""
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
func _load(filename: String) -> void:
	# Check if the SaveFile exists
	if filename == "":
		print("Error, filename is empty.")
		return
	
	var file_path = "user://" + filename
	if !FileAccess.file_exists(file_path):
		print("Error, no Save File to load.")
		return
	
	var save_file = FileAccess.open(file_path, FileAccess.READ) # Open File
	if save_file == null:
		print("Error, could not open Save File.")
		return
	
	var root_node = get_node("Root3D/SubViewportContainer/SubViewport/ConstMap")
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		var line = save_file.get_line()
		var err = json.parse(line)
		if err != OK:
			print("Error parsing JSON: ", line)
			continue
		
		# Get the Data
		var node_data = json.get_data()
		if not node_data.has("nodeName"):
			print("Error: 'nodeName' not found in data.")
			continue
		
		var node_instance = null
		
		match node_data["nodeName"]:
			"Forward":
				node_instance = Forward.instantiate()
			"Rotate":
				node_instance = Rotate.instantiate()
			"Color":
				node_instance = Colors.instantiate()
			"Checkpoint":
				node_instance = CheckPoint.instantiate()
			"Finish":
				node_instance = Finish.instantiate()
			"Square":
				node_instance = Square.instantiate()
			"Box":
				node_instance = Box.instantiate()
			_:
				print("Unknown node type: ", node_data["nodeName"])
				continue
		
		if node_instance:
			node_instance.loadObject(node_data)
			root_node.add_child(node_instance)
			node_instance.add_to_group("save")
	
	save_file.close() # Close File


func _on_load_pressed():
	
	blur_panel.show()
	load_panel.show()
	var mapsNAme =getMapFile() 
	var buttons 
	for i in mapsNAme:
		
		buttons = Buttons.instantiate() 
		
		buttons.get_child(0).text=i
		buttons.get_child(0).set("button_group",btn_group)
		load_map_list.add_child(buttons)
	for i in btn_group.get_buttons():
		i.connect("pressed",getName)
		
	pass # Replace with function body.

func getName():
	loadname=btn_group.get_pressed_button().text
	pass

func _on_back_pressed():
	get_tree().change_scene_to_packed(MainScene)
	pass # Replace with function body.

func _on_o_kload_pressed():
	if loadname != "":
	
		_clearMap()
		_load(loadname)
		blur_panel.hide()
		load_panel.hide()
		load_error_label.text = ""
		

		var children = load_map_list.get_children()
		for i in children:
			i.queue_free()
	else:
		load_error_label.text = "Выберите карту которую хотите редактировать"

func _on_cancelload_pressed():
	blur_panel.hide()
	load_panel.hide()
	load_error_label.text=""
	var children = load_map_list.get_children()
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



