"""
Дипломный проект по специальности 09.02.07 «Информационные системы и программирование»
по теме «Разработка программного обеспечения модульной платформы для обучения детей и конструирования
робототехнических систем»
Название: Globals.gd.
Разработал: Аль-Агабани Н. Н., группа ТИП-81.
Дата и номер версии: 19.05.2023 v2.12.3.
Язык: GdScript.
Краткое описание:
Данный модуль управляет списком утверждений и извлекает информацию о текущем утверждении или
конкретном утверждении в списке на основе его идентификатора или имени. Он также включает в себя
функции для удаления инструкции и проверки того, существует ли инструкция с определенным именем 
уже в списке. Кроме того, существуют функции для получения различных свойств инструкции, таких как
 управление, ультразвуковые показания, значения цвета, скорость, вращение, длительность, 
состояние светодиода и время.
Библиотеки, используемые в программе:
StItem самостоятельно написанный класс, хранящий в себе набор полей для сохранений кода написанным учеником
"""
extends Node

var statmentList = []
var CurrentStatment=null
var RobotRot=[]
var RobotPos=[]
var Checkpoint=0
var Finish=0
var Succesfull=false

func getDurationValue(statment):
	if CurrentStatment!=null:
		var id=statment.duration[0]
		var dur = _load_and_find(id+1)
		return str_to_var(dur)
	

func _load_and_find(id):
	var filename="res://Scene/Map/2d/duration/valueDuration/durFile.txt"
	if !FileAccess.file_exists(filename):
		print("Error, no Save File to load.")
		return
		
	var save_file = FileAccess.open(filename, FileAccess.READ) # Open File
	
	while save_file.get_position() < save_file.get_length():
		# Get the saved dictionary from the next line in the save file
		
		var dir =save_file.get_line().split(";")
		if str_to_var(dir[0])==id:
			save_file.close()
			return dir[1]
		# Get the Data
	save_file.close()
	
	
func deleteState():
	statmentList.erase(statmentList[CurrentStatment])
	pass
	
	
func isStateUseName(nameStat):
	for i in statmentList:
		if nameStat==i.stName:
			return false
	return true
	
	
func getStateByName(nameBtnCur):
	var index
	for i in range(0,statmentList.size()):
		if nameBtnCur==statmentList[i].stName:
			return i
	
	
func getStateById(id):
	return statmentList[id].stName
	
	
func getSteeringById():
	if CurrentStatment!=null:
		var steering = statmentList[CurrentStatment].steering
		return steering


func getStateLineById():
	if CurrentStatment!=null:
		var line = statmentList[CurrentStatment].line
		if line!=null:
			return line


func getStateUltraById():
	if CurrentStatment!=null:
		var ultra = statmentList[CurrentStatment].ultrasonic
		return ultra
	
		
func getStateColorRedById():
	if CurrentStatment!=null:
		var red = statmentList[CurrentStatment].colorRed
		return red
	
		
func getStateColorGreenById():
	if CurrentStatment!=null:
		var green = statmentList[CurrentStatment].colorGreen
		return green	
	
		
func getStateColorBlueById():
	if CurrentStatment!=null:
		var blue = statmentList[CurrentStatment].colorBlue
		return blue
		
		
func getStateSpeedById():
	if CurrentStatment!=null:
		var speed = statmentList[CurrentStatment].speed
		return speed
		
		
func getStateRotXById():
	if CurrentStatment!=null:
		var Rotx = statmentList[CurrentStatment].rotationX
		return Rotx

func getStateRotYById():
	if CurrentStatment!=null:
		var RotY = statmentList[CurrentStatment].rotationY
		return RotY

func getStateRotZById():
	if CurrentStatment!=null:
		var RotZ = statmentList[CurrentStatment].rotationZ
		return RotZ
		
func getStateDurationById():
	if CurrentStatment!=null:
		var duration = statmentList[CurrentStatment].duration
		return duration

func getStateLedById():
	if CurrentStatment!=null:
		var led = statmentList[CurrentStatment].led
		return led

func getStateTimeById():
	if CurrentStatment!=null:
		var time = statmentList[CurrentStatment].time
		return time
	
	

