extends Control
@onready var Duration = $TextureRect/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	size.x=1
	size.y=1
	pass # Replace with function body.

func setDurationByState():
	var dur=Globals.getStateDurationById()
	Duration.select(dur[0])
	pass



func _on_option_button_item_selected(index):
	var dur = Globals.getStateDurationById()
	dur[0]=index
	pass # Replace with function body.


