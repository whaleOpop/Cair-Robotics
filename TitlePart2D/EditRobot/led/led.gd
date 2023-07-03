extends Control

@onready var leds = $TextureRect/OptionButton
# Called when the node enters the scene tree for the first time.
func _ready():
	size.x=1
	size.y=1
	pass # Replace with function body.



func setLedByState():
	var dur=Globals.getStateLedById()
	
	leds.select(dur[0])
	
	pass



func _on_option_button_item_selected(index):
	var led = Globals.getStateLedById()
	led[0]=index
	pass # Replace with function body.



