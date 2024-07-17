extends Control

signal getName(names)

func setName(names_):
	$Button/Label.text=names_
	var stList = Globals.statmentList
	name=names_
	stList.append(Statment.new(names_))
	pass

func loadName(names_):
	$Button/Label.text=names_
	name=names_
	pass

func _on_button_pressed():
	getName.emit($Button/Label.text)
	pass # Replace with function body.
