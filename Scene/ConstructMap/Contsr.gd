extends CanvasLayer


@export var Forward = preload("res://TitlePart3D/prefabMaps/parts//Forward.tscn")
@export var Rotate = preload("res://TitlePart3D/prefabMaps/parts/Rotate.tscn")
@export var Colors = preload("res://TitlePart3D/prefabMaps/parts/Color.tscn")
@export var Finish = preload("res://TitlePart3D/prefabMaps/parts/Finish.tscn")
@export var CheckPoint = preload("res://TitlePart3D/prefabMaps/parts/Checkpoin.tscn")
@export var Square = preload( "res://TitlePart3D/prefabMaps/parts/Square.tscn")

@onready var ConstMap = $Root3D/SubViewportContainer/SubViewport/ConstMap

@onready var btnWB = $Root3D/Panel/TextureRect/TextureRect
@onready var btnRGB = $Root3D/Panel/TextureRect/TextureRect2

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
		btnRGB.visible=true
	elif SelectItem == 6:
		btnWB.visible=true
	
			
	print(SelectItem)
	pass # Replace with function body.



var colorPicker = Color.DARK_CYAN
var wb = null

var matWhite = StandardMaterial3D.new()
var matBlack = StandardMaterial3D.new()

	
func _ready():
	matBlack.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matBlack.albedo_color=Color.BLACK
	
	matWhite.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matWhite.albedo_color=Color.WHITE
	pass
	
func _on_add_button_down():
	var ItemCell = Node3D.new()
	
	
	if SelectItem == 0:
	
		var forward = Forward.instantiate()
		var matLine = forward.get_child(0)
		var matSquare = forward.get_child(1)
		if !wb:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
		ItemCell.add_child(forward)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
	
	elif SelectItem==1:
		var rotate = Rotate.instantiate()
		var matLine = rotate.get_child(0)
		var matSquare = rotate.get_child(1)
		if !wb:
			matLine.set("surface_material_override/0",matBlack)
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matLine.set("surface_material_override/0",matWhite)
			matSquare.set("surface_material_override/0",matBlack)
		ItemCell.add_child(rotate)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
		
	elif SelectItem==2:
		var colors = Colors.instantiate()
		var matColor = StandardMaterial3D.new()
		var matMesh = colors.get_child(0)
		matMesh.set("surface_material_override/0",matColor)
		matColor.albedo_color=colorPicker
		matColor.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
		ItemCell.add_child(colors)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
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
		ItemCell.add_child(finish)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
	elif SelectItem==4:
		var checkPoint =CheckPoint.instantiate()
		var matLine = checkPoint.get_child(0)
		var matSquare = checkPoint.get_child(1)
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
		ItemCell.add_child(checkPoint)
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
	elif SelectItem==5:
		print("5")
	elif SelectItem==6:
		var square= Square.instantiate()
		var matSquare = square.get_child(0)
		if !wb:
			matSquare.set("surface_material_override/0",matWhite)
		else:
			matSquare.set("surface_material_override/0",matBlack)
		ItemCell.add_child(square)	
		get_node("Root3D/SubViewportContainer/SubViewport/ConstMap").add_child(ItemCell)
	else:
		SelectItem=null
		ItemCell=null
		pass
	
	
	pass # Replace with function body.


func _on_wb_toggled(button_pressed):
	wb=button_pressed
	pass # Replace with function body.


func _on_rgb_color_changed(color):
	colorPicker=color
	pass # Replace with function body.
