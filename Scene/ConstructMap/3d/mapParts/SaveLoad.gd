"""
Краткое описание:
Этот скрипт содержит методы для сохранения и загрузки объектов в 3D-сцене.

Метод saveObject используется для сохранения параметров объекта в словарь, который может быть легко
 преобразован в формат JSON или другой формат для хранения данных. В зависимости от имени объекта 
(metadata/NameCell) создается соответствующий словарь с параметрами объекта. Например, для объекта 
с именем "Forward" сохраняются его позиция, поворот и цвета материалов линии и меша.

Метод loadObject используется для загрузки параметров объекта из словаря. Он также использует 
имя объекта, чтобы определить, какие параметры нужно загрузить. Затем он создает новые материалы 
с соответствующими цветами и устанавливает их в качестве материалов на дочерние узлы объекта.

Функции parseVec4 и parseVec3 используются для преобразования строкового представления вектора в 
тип Color или Vector3, соответственно.

Таким образом, этот скрипт предоставляет набор методов для сохранения и загрузки параметров объектов 
в 3D-сцене, что может быть полезным при создании игр или других приложений, которые используют 3D-графику.
"""

extends Node3D


func saveObject() :
	
	if get("metadata/NameCell")=="Forward":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColorLine": get_child(1).get("surface_material_override/0").get("albedo_color"),
			"albedoColorMesh": get_child(0).get("surface_material_override/0").get("albedo_color")
		}
		return dict
	elif get("metadata/NameCell")=="Rotate":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColorLine": get_child(1).get("surface_material_override/0").get("albedo_color"),
			"albedoColorMesh": get_child(0).get("surface_material_override/0").get("albedo_color")
		}
		return dict
	elif get("metadata/NameCell")=="Color":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColor": get_child(0).get("surface_material_override/0").get("albedo_color")
			
		}
		return dict
	elif get("metadata/NameCell")=="Finish":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColorMesh": get_child(0).get("surface_material_override/0").get("albedo_color"),
			"albedoColorLine": get_child(1).get("surface_material_override/0").get("albedo_color")
		}
		return dict
	elif get("metadata/NameCell")=="Checkpoint":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColorLine": get_child(1).get("surface_material_override/0").get("albedo_color"),
			"albedoColor": get_child(2).get("surface_material_override/0").get("albedo_color"),
			"albedoColorMesh": get_child(0).get("surface_material_override/0").get("albedo_color")
		}
		return dict
	elif get("metadata/NameCell")=="Square":
		var dict := {
			"nodeName" : get("metadata/NameCell"),
			"position": position,
			"rotation_degrees": rotation_degrees,
			"albedoColorMesh": get_child(0).get("surface_material_override/0").get("albedo_color")
		}
		return dict
	pass
	
func loadObject(loadedDict: Dictionary) -> void:
	var matWhite = StandardMaterial3D.new()
	var matBlack = StandardMaterial3D.new()
	var matColor = StandardMaterial3D.new()
	matWhite.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matBlack.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	matColor.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	if get("metadata/NameCell")=="Forward":

		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		matBlack.albedo_color=parseVec4(loadedDict.albedoColorLine)
		matWhite.albedo_color=parseVec4(loadedDict.albedoColorMesh)
		get_child(1).set("surface_material_override/0",matBlack)
		get_child(0).set("surface_material_override/0",matWhite)

	elif get("metadata/NameCell")=="Rotate":
		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		matBlack.albedo_color=parseVec4(loadedDict.albedoColorLine)
		matWhite.albedo_color=parseVec4(loadedDict.albedoColorMesh)
		get_child(0).set("surface_material_override/0",matWhite)
		get_child(1).set("surface_material_override/0",matBlack)
	elif get("metadata/NameCell")=="Color":
		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		matColor.albedo_color=parseVec4(loadedDict.albedoColor)
		get_child(0).set("surface_material_override/0",matColor)
	elif get("metadata/NameCell")=="Finish":
		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		matBlack.albedo_color=parseVec4(loadedDict.albedoColorLine)
		matWhite.albedo_color=parseVec4(loadedDict.albedoColorMesh)
		get_child(1).set("surface_material_override/0",matBlack)
		get_child(0).set("surface_material_override/0",matWhite)
		
		
	elif get("metadata/NameCell")=="Checkpoint":
		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		
		matBlack.albedo_color=parseVec4(loadedDict.albedoColorLine)
		matWhite.albedo_color=parseVec4(loadedDict.albedoColorMesh)
		matColor.albedo_color=parseVec4(loadedDict.albedoColor)
		get_child(1).set("surface_material_override/0",matBlack)
		get_child(0).set("surface_material_override/0",matWhite)
		get_child(2).set("surface_material_override/0",matColor)
	elif get("metadata/NameCell")=="Square":
		position =parseVec3(loadedDict.position)
		rotation_degrees = parseVec3(loadedDict.rotation_degrees)
		matWhite.albedo_color=parseVec4(loadedDict.albedoColorMesh)
		get_child(0).set("surface_material_override/0",matWhite)
		
		
	pass


func parseVec4(strVec):
	var vec4 = Color()
	strVec=strVec.replace("(","").replace(")","")
	var pos = strVec.split(",")
	vec4.r=float(pos[0])
	vec4.g=float(pos[1])
	vec4.b=float(pos[2])
	vec4.a=float(pos[3])
	return vec4
	
func parseVec3(strVec):
	var vec3 = Vector3()
	strVec=strVec.replace("(","").replace(")","")
	var pos = strVec.split(",")
	vec3.x=float(pos[0])
	vec3.y=float(pos[1])
	vec3.z=float(pos[2])
	return vec3
@onready var Car = preload("res://Scene/Car/Car.tscn")

var isUsed=true
func _on_area_3d_body_entered(body):
	if body.get_class()=="VehicleBody3D":
		if (isUsed):
			Globals.Checkpoint+=1
			isUsed=false
	pass # Replace with function body.
	
	
func reset():
	isUsed=true



func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(local_shape_index)
	print(body_rid)
	print(body_shape_index)
	pass # Replace with function body.


func _on_finish_body_entered(body):
	if body.get_class()=="VehicleBody3D":
		if Globals.Finish==Globals.Checkpoint:
			Globals.Succesfull=true
			body.get_parent().queue_free()
	pass # Replace with function body.
