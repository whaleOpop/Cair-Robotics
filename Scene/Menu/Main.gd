extends CanvasLayer

@export var Buttons := preload("res://Scene/Menu/2d/mapList/button.tscn")
@export var ConstructMap := preload("res://Scene/ConstructMap/ConstructMapViewport.tscn")

@onready var menu_panel = $Root3D/Menu_panel
@onready var menu_map_list_panel = $Root3D/Menu_MapList_panel
@onready var vbox_map_list = $Root3D/Menu_MapList_panel/TextureRect/VScrollBar/VBoxContainer


func _on_onst_map_pressed():
	get_tree().change_scene_to_packed(ConstructMap)


func _on_maps_pressed():
	menu_map_list_panel.show()
	menu_panel.hide()
	var map_names = get_map_files()
	var container = vbox_map_list

	for name in map_names:
		var button = Buttons.instantiate()
		button.get_child(0).text = name
		container.add_child(button)


func _on_button_pressed():
	menu_map_list_panel.hide()
	menu_panel.show()
	var container = vbox_map_list

	for child in container.get_children():
		child.queue_free()

func get_map_files() -> Array:
	var files = []
	var dir = DirAccess.open("user://")

	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()

		while file:
			if not file.begins_with(".") and file.get_extension() == "cair":
				files.append(file)
			file = dir.get_next()

		dir.list_dir_end()

	return files

func _on_exit_pressed():
	get_tree().quit()
