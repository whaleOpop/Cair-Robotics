extends Node3D

func saveObject() -> Dictionary:
	var node_name = get("metadata/NameCell")
	var dict = {
		"nodeName": node_name,
		"position": str(position),
		"rotation_degrees": str(rotation_degrees)
	}

	match node_name:
		"Forward", "Rotate", "Finish", "Checkpoint":
			dict["albedoColorLine"] = str(get_child(1).get("surface_material_override/0").get("albedo_color"))
			dict["albedoColorMesh"] = str(get_child(0).get("surface_material_override/0").get("albedo_color"))
		"Color":
			dict["albedoColor"] = str(get_child(0).get("surface_material_override/0").get("albedo_color"))
		"Square":
			dict["albedoColorMesh"] = str(get_child(0).get("surface_material_override/0").get("albedo_color"))

	if node_name == "Checkpoint":
		dict["albedoColor"] = str(get_child(2).get("surface_material_override/0").get("albedo_color"))

	return dict

func loadObject(loadedDict: Dictionary) -> void:
	var node_name = loadedDict["nodeName"]
	position = parseVec3(loadedDict["position"])
	rotation_degrees = parseVec3(loadedDict["rotation_degrees"])

	var mat_black = StandardMaterial3D.new()
	var mat_white = StandardMaterial3D.new()
	var mat_color = StandardMaterial3D.new()

	mat_black.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat_white.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat_color.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	match node_name:
		"Forward", "Rotate", "Finish", "Checkpoint":
			mat_black.albedo_color = parseVec4(loadedDict["albedoColorLine"])
			mat_white.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			get_child(1).set("surface_material_override/0", mat_black)
			get_child(0).set("surface_material_override/0", mat_white)
		"Color":
			mat_color.albedo_color = parseVec4(loadedDict["albedoColor"])
			get_child(0).set("surface_material_override/0", mat_color)
		"Square":
			mat_white.albedo_color = parseVec4(loadedDict["albedoColorMesh"])
			get_child(0).set("surface_material_override/0", mat_white)

	if node_name == "Checkpoint" and "albedoColor" in loadedDict:
		mat_color.albedo_color = parseVec4(loadedDict["albedoColor"])
		get_child(2).set("surface_material_override/0", mat_color)

func parseVec4(strVec: String) -> Color:
	var vec4 = strVec.strip_edges().replace("(", "").replace(")", "").split(",")
	return Color(vec4[0].to_float(), vec4[1].to_float(), vec4[2].to_float(), vec4[3].to_float())

func parseVec3(strVec: String) -> Vector3:
	var vec3 = strVec.strip_edges().replace("(", "").replace(")", "").split(",")
	return Vector3(vec3[0].to_float(), vec3[1].to_float(), vec3[2].to_float())

@onready var Car = preload("res://Scene/Car/Car.tscn")

var isUsed = true

func _on_area_3d_body_entered(body):
	if body.get_class() == "RigidBody3D" and isUsed:
		Globals.Checkpoint += 1
		isUsed = false

func reset():
	isUsed = true

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass

func _on_finish_body_entered(body):
	if body.get_class() == "RigidBody3D":
		if Globals.Finish == Globals.Checkpoint:
			Globals.Succesfull = true
			body.get_parent().queue_free()
