"""
Краткое описание:
Этот скрипт отвечает за взаимодействие с меню выбора карты и загрузку списка сохраненных карт. 

Скрипт содержит функции, которые вызываются при нажатии на кнопки в меню.

Функция _on_onst_map_pressed вызывается при нажатии на кнопку для создания новой карты. Она 
использует метод change_scene_to_packed, чтобы загрузить сцену, в которой пользователь может 
создавать новую карту.

Функция _on_maps_pressed вызывается при нажатии на кнопку для отображения списка сохраненных карт. 
Она отображает список карт в экранном меню, используя префаб кнопки из файла button.tscn, который был 
предварительно загружен в переменную Buttons. Для каждой сохраненной карты создается новая кнопка, содержащая имя карты, и добавляется в контейнер VBoxContainer в меню. Для получения списка сохраненных карт используется функция getMapFile, которая возвращает массив имен файлов с расширением .cair из директории res://.

Функция _on_button_pressed вызывается при нажатии на кнопку закрытия меню выбора карты. Она скрывает
меню выбора карты и очищает контейнер VBoxContainer, удаляя все созданные кнопки.

В целом, данный скрипт позволяет пользователю выбирать между созданием новой карты или загрузкой 
сохраненной карты.
"""

extends CanvasLayer

var ConstructMap = preload("res://Scene/ConstructMap/ConstructorMap.tscn")

@export var Buttons = preload("res://TitlePart2D/Menu/mapList/button.tscn")

func _ready():
	

	pass


func _on_onst_map_pressed():
	get_tree().change_scene_to_packed(ConstructMap)
	pass # Replace with function body.

func _on_maps_pressed():
	$Root3D/mapslist.show()
	$Root3D/Panel.hide()
	var mapsNAme =getMapFile() 
	for i in mapsNAme:
		var buttons = Buttons.instantiate() 
		buttons.get_child(0).text=i
		$Root3D/mapslist/TextureRect/VScrollBar/VBoxContainer.add_child(buttons)
	pass # Replace with function body.


func _on_button_pressed():
	$Root3D/mapslist.hide()
	$Root3D/Panel.show()
	var children = $Root3D/mapslist/TextureRect/VScrollBar/VBoxContainer.get_children()
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


func _on_exit_pressed():
	
	get_tree().quit()
	pass # Replace with function body.
