extends Node3D

func saveObject():
	var name_cell = get("metadata/NameCell")
	var dict = {
		"nodeName": name_cell,
		"position": position,
		"rotation_degrees": rotation_degrees,
	}
	
	var albedo_colors = get_albedo_colors(name_cell)
	for key in albedo_colors.keys():
		dict[key] = albedo_colors[key]

	return dict

func get_albedo_colors(name_cell):
	var colors = {}
	match name_cell:
		"Forward", "Rotate", "Finish", "Checkpoint":
			colors["albedoColorLine"] = get_child(1).get("surface_material_override/0").get("albedo_color")
		"Forward", "Rotate", "Finish", "Square":
			colors["albedoColorMesh"] = get_child(0).get("surface_material_override/0").get("albedo_color")
		"Color", "Checkpoint":
			colors["albedoColor"] = get_child(0).get("surface_material_override/0").get("albedo_color")
		"Checkpoint":
			colors["albedoColorMesh"] = get_child(0).get("surface_material_override/0").get("albedo_color")
			colors["albedoColor"] = get_child(2).get("surface_material_override/0").get("albedo_color")
	return colors

func loadObject(loadedDict: Dictionary) -> void:
	var matWhite = StandardMaterial3D.new()
	var matBlack = StandardMaterial3D.new()
	var matColor = StandardMaterial3D.new()
	
	matWhite.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	matBlack.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	matColor.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	var name_cell = get("metadata/NameCell")

	position = parseVec3(loadedDict["position"])
	rotation_degrees = parseVec3(loadedDict["rotation_degrees"])
	
	set_albedo_colors(name_cell, loadedDict, matWhite, matBlack, matColor)

func set_albedo_colors(name_cell, loadedDict, matWhite, matBlack, matColor):
	match name_cell:
		"Forward", "Finish":
			matBlack.albedo_color = parseVec4(loadedDict["albedoColorLine"])
			matWhite.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			get_child(1).set("surface_material_override/0", matBlack)
			get_child(0).set("surface_material_override/0", matWhite)
		"Rotate":
			matBlack.albedo_color = parseVec4(loadedDict["albedoColorLine"])
			matWhite.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			get_child(0).set("surface_material_override/0", matWhite)
			get_child(1).set("surface_material_override/0", matBlack)
		"Color":
			matColor.albedo_color = parseVec4(loadedDict["albedoColor"])
			get_child(0).set("surface_material_override/0", matColor)
		"Checkpoint":
			matBlack.albedo_color = parseVec4(loadedDict["albedoColorLine"])
			matWhite.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			matColor.albedo_color = parseVec4(loadedDict["albedoColor"])
			get_child(1).set("surface_material_override/0", matBlack)
			get_child(0).set("surface_material_override/0", matWhite)
			get_child(2).set("surface_material_override/0", matColor)
		"Square":
			matWhite.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			get_child(0).set("surface_material_override/0", matWhite)

func parseVec4(strVec):
	var vec4 = Color()
	strVec = strVec.replace("(", "").replace(")", "")
	var pos = strVec.split(",")
	vec4.r = float(pos[0])
	vec4.g = float(pos[1])
	vec4.b = float(pos[2])
	vec4.a = float(pos[3])
	return vec4
	
func parseVec3(strVec):
	var vec3 = Vector3()
	strVec = strVec.replace("(", "").replace(")", "")
	var pos = strVec.split(",")
	vec3.x = float(pos[0])
	vec3.y = float(pos[1])
	vec3.z = float(pos[2])
	return vec3

@onready var Car = preload("res://Scene/Car/Car.tscn")

var isUsed = true

func _on_area_3d_body_entered(body):
	if body.get_class() == "VehicleBody3D":
		if isUsed:
			Globals.Checkpoint += 1
			isUsed = false

func reset():
	isUsed = true

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(local_shape_index)
	print(body_rid)
	print(body_shape_index)

func _on_finish_body_entered(body):
	if body.get_class() == "VehicleBody3D":
		if Globals.Finish == Globals.Checkpoint:
			Globals.Succesfull = true
			body.get_parent().queue_free()
