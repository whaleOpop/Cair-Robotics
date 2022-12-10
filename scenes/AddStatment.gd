extends WindowDialog

signal updated(nameBtn)

func open(nameBtn = ""):
	find_node("NameBtn").text = nameBtn
	popup_centered()




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Okey_button_down():
	var title = find_node("NameBtn").text.strip_edges()
	if title.empty():
		title="Untiled"
	emit_signal("updated",title)
	hide()
	pass # Replace with function body.


func _on_Cancel_button_down():
	hide()
	pass # Replace with function body.
