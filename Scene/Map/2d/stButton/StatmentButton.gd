extends Control
@onready var st = get_node("/root/Globals")
signal getName(names)
#@onready var stIt = get_node("/root/StItem")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
	
func setName(names_):
	$Button/Label.text=names_
	var stList = Globals.statmentList
	name=names_
	stList.append(Statment.new(names_))
	pass




func _on_button_pressed():
	getName.emit($Button/Label.text)
	
	pass # Replace with function body.
