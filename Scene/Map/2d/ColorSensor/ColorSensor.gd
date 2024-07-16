extends Control

@onready var RedMin = $RedMin
@onready var GreenMin = $GreenMin
@onready var BlueMin = $BlueMin
@onready var RedMax = $RedMax
@onready var GreenMax = $GreenMax
@onready var BlueMax = $BlueMax
@onready var colorRect = $ColorRect

func _ready():
	set_default_max_values()
	update_color_rect()

func set_default_max_values():
	RedMax.text = "255"
	GreenMax.text = "255"
	BlueMax.text = "255"

func update_color_rect():
	colorRect.color = Color(
		int(RedMax.text) / 255.0,
		int(GreenMax.text) / 255.0,
		int(BlueMax.text) / 255.0,
		1.0
	)

func set_color_by_state():
	var red = Globals.getStateColorRedById()
	var green = Globals.getStateColorGreenById()
	var blue = Globals.getStateColorBlueById()
	set_color_fields(red, green, blue)
	update_color_rect()

func set_color_fields(red, green, blue):
	RedMin.text = str(red[0])
	RedMax.text = str(red[1])
	GreenMin.text = str(green[0])
	GreenMax.text = str(green[1])
	BlueMin.text = str(blue[0])
	BlueMax.text = str(blue[1])

func update_state_color(channel, index, new_text):
	var value = clamp(int(new_text), 0, 255)
	new_text = str(value)  # Update the text field with clamped value
	match channel:
		"red":
			Globals.getStateColorRedById()[index] = value
		"green":
			Globals.getStateColorGreenById()[index] = value
		"blue":
			Globals.getStateColorBlueById()[index] = value
	update_color_rect()

func _on_red_min_text_changed(new_text):
	update_state_color("red", 0, new_text)

func _on_red_max_text_changed(new_text):
	update_state_color("red", 1, new_text)

func _on_green_min_text_changed(new_text):
	update_state_color("green", 0, new_text)

func _on_green_max_text_changed(new_text):
	update_state_color("green", 1, new_text)

func _on_blue_min_text_changed(new_text):
	update_state_color("blue", 0, new_text)

func _on_blue_max_text_changed(new_text):
	update_state_color("blue", 1, new_text)
