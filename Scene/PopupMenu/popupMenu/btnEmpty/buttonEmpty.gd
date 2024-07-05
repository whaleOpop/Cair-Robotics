extends Control

signal getname(name)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_button_pressed():
	getname.emit($Button.text)
	pass # Replace with function body.


