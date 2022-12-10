extends Node
class Statment:
	
	func _init(param_name):
		stName = param_name
	
	var stName
	var line = [0,0,0,0,0,0]
	var ultrasonic = []
	var colorGreen = []
	var colorRed = []
	var colorBlue = []
	var speed = []
	var rotationX=[]
	var rotationZ=[]
	var rotationY=[]
	var scripts = []
	var options = [] 
	
	func setColor(Rmin,Rmax,Gmin,Gmax,Bmin,Bmax):
		colorRed[0]=Rmin
		colorRed[1]=Rmax
		colorGreen[0]=Gmin
		colorGreen[1]=Gmax
		colorBlue[0]=Bmin
		colorBlue[1]=Bmax
		
	func setLine(param_line):
		line= param_line
		
	func setRotationX(x1,x2):
		rotationX[0]=x1
		rotationX[1]=x2
			
	func setRotationY(y1,y2):
		rotationY[0]=y1
		rotationY[1]=y2
		
	func setRotationZ(z1,z2):
		rotationZ[0]=z1
		rotationZ[1]=z2
	
	func setSpeed(leftF,leftB,rightF,rightB):
		speed[0]=leftF
		speed[1]=leftB
		speed[2]=rightF
		speed[3]=rightB
	
	func setLed(led):
		options[0]=led
		
	func setDuration(dur):
		options[1]=dur
	
	func setTime(timer):
		options[2]=timer
	
	func getLine():
		return line
	
var StatmentList = []
	
var CurrentSt

func seatchElem(nameBtnCur):
	var index
	for i in range(0,StatmentList.size()):
		if nameBtnCur==StatmentList[i].stName:
			index =i
	return index
	
	
	
	

