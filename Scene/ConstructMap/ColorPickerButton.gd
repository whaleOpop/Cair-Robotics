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
