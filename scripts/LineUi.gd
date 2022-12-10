extends Button


signal getLine(line)



func setLine(line):
	$l3.set("selected",line[0])
	$l2.set("selected",line[1])
	$l1.set("selected",line[2])
	$r1.set("selected",line[3])
	$r2.set("selected",line[4])
	$r3.set("selected",line[5])

func _ready():
	pass 


var lineDefault = [0,0,0,0,0,0]


func _on_l3_item_selected(index):
	lineDefault[0]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.


func _on_l2_item_selected(index):
	lineDefault[1]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.


func _on_l1_item_selected(index):
	lineDefault[2]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.


func _on_r1_item_selected(index):
	lineDefault[3]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.


func _on_r2_item_selected(index):
	lineDefault[4]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.


func _on_r3_item_selected(index):
	lineDefault[5]=index
	emit_signal("getLine",lineDefault)
	lineDefault=[0,0,0,0,0,0]
	pass # Replace with function body.
