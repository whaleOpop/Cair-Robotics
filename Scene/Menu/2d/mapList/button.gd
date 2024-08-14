extends Control
var Map = preload("res://Scene/Map/Map.tscn").instantiate()

@export var Forward = preload("res://Scene/ConstructMap/3d/mapParts/Forward.tscn")
@export var Rotate = preload("res://Scene/ConstructMap/3d/mapParts/Rotate.tscn")
@export var Colors = preload("res://Scene/ConstructMap/3d/mapParts/Color.tscn")
@export var Finish = preload("res://Scene/ConstructMap/3d/mapParts/Finish.tscn")
@export var CheckPoint = preload("res://Scene/ConstructMap/3d/mapParts/Checkpoint.tscn")
@export var Square = preload( "res://Scene/ConstructMap/3d/mapParts/Square.tscn")
@export var Box = preload( "res://Scene/ConstructMap/3d/mapParts/Box.tscn")


var mapLoader = Map.get_child(0).get_child(0).get_child(0).get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _load(filename: String) -> void:
	# Check if the SaveFile exists
	if filename == "":
		print("Error, filename is empty.")
		return
	
	var file_path = "user://" + filename
	if !FileAccess.file_exists(file_path):
		print("Error, no Save File to load.")
		return
	
	var save_file = FileAccess.open(file_path, FileAccess.READ) # Open File
	if save_file == null:
		print("Error, could not open Save File.")
		return
	
	var root_node = get_node("Root3D/SubViewportContainer/SubViewport/ConstMap")
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		var json = JSON.new()
		var line = save_file.get_line()
		var err = json.parse(line)
		if err != OK:
			print("Error parsing JSON: ", line)
			continue
		
		# Get the Data
		var node_data = json.get_data()
		if not node_data.has("nodeName"):
			print("Error: 'nodeName' not found in data.")
			continue
		
		var node_instance = null
		
		match node_data["nodeName"]:
			"Forward":
				node_instance = Forward.instantiate()
			"Rotate":
				node_instance = Rotate.instantiate()
			"Color":
				node_instance = Colors.instantiate()
			"Checkpoint":
				node_instance = CheckPoint.instantiate()
			"Finish":
				node_instance = Finish.instantiate()
				Globals.RobotPos[0]=parseVec3(node_data["position"])
				Globals.RobotRot[0]=parseVec3(node_data["rotation_degrees"])
			"Square":
				node_instance = Square.instantiate()
			"Box":
				node_instance = Box.instantiate()
			_:
				print("Unknown node type: ", node_data["nodeName"])
				continue
		
		if node_instance:
			node_instance.loadObject(node_data)
			mapLoader.add_child(node_instance)
			node_instance.add_to_group("save")
	
	save_file.close() # Close File



func _on_button_pressed():
	get_tree().get_root().get_child(1).queue_free()
	_load($Button.text)
	get_tree().get_root().add_child(Map)
	
	pass # Replace with function body.
	
func parseVec3(strVec: String) -> Vector3:
	var vec3 = strVec.strip_edges().replace("(", "").replace(")", "").split(",")
	return Vector3(vec3[0].to_float(), vec3[1].to_float(), vec3[2].to_float())
