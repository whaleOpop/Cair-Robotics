
extends Node

onready var lineUi = get_node("Panel/Line")
onready var st = get_node("/root/Statments")

onready var anim = $AnimationPlayer

var nameBtnCur
func _ready():
	
	pass


func _process(_delta):
	
	pass



func _on_PlusButton_pressed():
	$Panel/AddStatment.open()
	
	pass # Replace with function body.


func _on_AddStatment_updated(nameBtn):
	nameBtnCur=nameBtn
	var button_pck = preload("res://scenes/Button.tscn")
	var button = button_pck.instance()
	button.set_something(nameBtn)
	$Panel/ListStatments/VBoxList.add_child(button)
	st.StatmentList.append(st.Statment.new(nameBtn))
	button.connect("button_up",self,"_on_Button_button_up")
	pass # Replace with function body.


var flagOpen
func _on_Button_button_up():
	print(st.CurrentSt)
	print(2)
	$Panel/NameSt.set("text",st.CurrentSt)
	print(st.StatmentList[st.seatchElem(st.CurrentSt)].getLine())
	lineUi.setLine(st.StatmentList[st.seatchElem(st.CurrentSt)].line)
	print(st.StatmentList[st.seatchElem(st.CurrentSt)].stName)
	
	
func _on_Line_button_down():
	if flagOpen==false:
		anim.play("animopenH")
		flagOpen = true
	else:
		anim.play_backwards("animopenH")
		flagOpen = false
	pass # Replace with function body.


func _on_Line_getLine(line):
	if !st.StatmentList.size()==0:
		st.StatmentList[st.seatchElem(st.CurrentSt)].setLine(line)
	pass # Replace with function body.
