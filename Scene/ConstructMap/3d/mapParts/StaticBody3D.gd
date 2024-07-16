"""
Краткое описание:
Этот скрипт представляет из себя компонент статического тела в 3D-сцене. Он реагирует на событие 
_on_interact, которое генерируется при взаимодействии пользователя с объектом, и генерирует сигналы 
cell_pressed и obj_link.

Сигнал cell_pressed вызывается, когда пользователь выбирает или отменяет выбор объекта. Он принимает 
булево значение, которое указывает, выбран ли объект. Для этого скрипта используется переменная 
metadata/isSelected, которая устанавливается в true, если объект выбран, и в false, если нет.

Сигнал obj_link генерируется, когда пользователь связывает объект с другим объектом в игре. Он 
передает ссылку на связанный объект.

Функция _get_color возвращает цвет материала объекта. Она использует метод get_surface_override_material,
чтобы получить материал устанавленного на объекте. Затем она возвращает значение его альбедо цвета (albedo_color).

Таким образом, этот скрипт может быть полезен для создания игр или других приложений, которые 
требуют интерактивности с объектами в 3D-сцене.
"""

extends StaticBody3D

signal cell_pressed(value:bool) 
signal obj_link(link) 

func _on_interact():
	obj_link.emit($"../..")
	if($"../..".get("metadata/isSelected")):
		
		cell_pressed.emit($"../..".get("metadata/isSelected"))
		$"../..".set("metadata/isSelected",false)
		print($"../..")
	else:
		cell_pressed.emit($"../..".get("metadata/isSelected"))
		$"../..".set("metadata/isSelected",true)
		print($"../..")
	return "cell"

func _get_color():
	var mat = $"..".get_surface_override_material(0)
	return mat.get("albedo_color")
