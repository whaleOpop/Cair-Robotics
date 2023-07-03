"""Описание:
Этот код описывает класс, который наследуется от класса ColorPickerButton в Godot Engine. Он имеет функцию "_ready", которая вызывается, когда узел первый раз появляется в дереве сцены.

Функция "_ready" выполняет следующие действия:

Получает объект "color_picker", который представляет элемент выбора цвета.
Устанавливает режим выбора цвета на RGB.
Скрывает видимость режимов выбора цвета.
Отключает редактирование прозрачности.
Скрывает отображение шестнадцатеричной кодировки цвета.
Устанавливает форму элемента выбора цвета в виде круга VHS.
Скрывает отображение сохраненных цветов.
Библиотеки, используемые в программе:
Отсутствуют.
"""
extends ColorPickerButton


# Called when the node enters the scene tree for the first time.
func _ready():
	var color_picker =get_picker()
	color_picker.color_mode=ColorPicker.MODE_RGB
	color_picker.color_modes_visible = false
	color_picker.edit_alpha = false
	color_picker.hex_visible = false
	color_picker.set_picker_shape(ColorPicker.SHAPE_VHS_CIRCLE)
	color_picker.presets_visible=false
	
	pass # Replace with function body.
