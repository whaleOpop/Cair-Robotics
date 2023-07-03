extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	_load()
	pass # Replace with function body.




func _load():
	var filename="durFile.txt"
	if !FileAccess.file_exists(filename):
		print("Error, no Save File to load.")
		return
		
	var save_file = FileAccess.open(filename, FileAccess.READ) # Open File
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		
		var dir =save_file.get_line().split(";")

		add_item(dir[1],str_to_var(dir[0]))
		# Get the Data
	save_file.close()
	
	
