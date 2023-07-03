extends Control
var Map = preload("res://Scene/Map/Map.tscn").instantiate()

@export var Forward = preload("res://TitlePart3D/prefabMaps/parts/Forward.tscn")
@export var Rotate = preload("res://TitlePart3D/prefabMaps/parts/Rotate.tscn")
@export var Colors = preload("res://TitlePart3D/prefabMaps/parts/Color.tscn")
@export var Finish = preload("res://TitlePart3D/prefabMaps/parts/Finish.tscn")
@export var CheckPoint = preload("res://TitlePart3D/prefabMaps/parts/Checkpoint.tscn")
@export var Square = preload( "res://TitlePart3D/prefabMaps/parts/Square.tscn")

var mapLoader = Map.get_child(0).get_child(0).get_child(0).get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _load(filename) -> void:
	# Check if the SaveFile exists
	if !FileAccess.file_exists("user://"+filename):
		print("Error, no Save File to load.")
		return
	
	var save_file = FileAccess.open("user://"+filename, FileAccess.READ) # Open File
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		json.parse(save_file.get_line())
		
		# Get the Data
		var node_data = json.get_data()
		
		print(node_data["nodeName"])
		if node_data["nodeName"]=="Forward":
			var forward = Forward.instantiate()
			forward.loadObject(node_data)
			mapLoader.add_child(forward)
			forward.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Rotate":
			var rotate = Rotate.instantiate()
			rotate.loadObject(node_data)
			mapLoader.add_child(rotate)
			rotate.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Color":
			var colors = Colors.instantiate()
			colors.loadObject(node_data)
			mapLoader.add_child(colors)
			colors.add_to_group("save");
			#get_node(node_data["nodeName"]).loadObject(node_data)
		elif node_data["nodeName"]=="Checkpoint":
			var checkPoint = CheckPoint.instantiate()
			checkPoint.loadObject(node_data)
			mapLoader.add_child(checkPoint)
			checkPoint.add_to_group("save");
			Globals.Finish+=1

			#get_node(node_data["nodeName"]).loadObject(node_data)
			
		elif node_data["nodeName"]=="Finish":
			var finish = Finish.instantiate()
			finish.loadObject(node_data)
			Globals.RobotRot.insert(0,finish.rotation_degrees)
			Globals.RobotPos.insert(0,finish.position)
			mapLoader.add_child(finish)
			#get_node(node_data["nodeName"]).loadObject(node_data)
			finish.add_to_group("save");
			
		elif node_data["nodeName"]=="Square":
			var square = Square.instantiate()
			square.loadObject(node_data)
			mapLoader.add_child(square)
			square.add_to_group("save");
		
		
	save_file.close() # Close File
	pass


func _on_button_pressed():
	get_tree().get_root().get_child(1).queue_free()
	_load($Button.text)
	get_tree().get_root().add_child(Map)
	
	pass # Replace with function body.
