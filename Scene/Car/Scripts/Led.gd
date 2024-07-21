extends Node3D

class_name Led
# Класс `Led` наследуется от `Node3D` и предназначен для управления LED-диодом в игровом движке Godot Engine.
# Это позволяет управлять состоянием LED (включено, выключено, мигание), используя различные методы.

# `led_mesh` ссылается на меш, который представляет физическую форму LED.
@onready var led_mesh = $CSGBox3D

# `led_anim` ссылается на AnimationPlayer, который используется для воспроизведения анимации мигания LED.
@onready var led_anim = $"../../AnimationPlayer"

# Переменная `ledState` хранит текущее состояние LED (0 - выключено, 1 - включено).
var ledState

# Функция `_ready()` вызывается при инициализации узла.
# Здесь устанавливается начальное состояние LED - невидимое.
func _ready():
	led_mesh.visible=false
	pass 

# Функция `set_led()` принимает индекс состояния и устанавливает соответствующее состояние LED.
# Индексы: 0 - выключено, 1 - включено, 2 - мигание.
func set_led(index):
	if index==0:
		offLed()
	elif index ==1:
		onLed()
	elif index == 2:
		flashLed()
	pass

# Функция `offLed()` устанавливает LED в состояние "выключено".
func offLed():
	led_mesh.visible=false
	ledState=0
	pass 

# Функция `get_state_led()` возвращает текущее состояние LED.
func get_state_led():
	return ledState

# Функция `onLed()` устанавливает LED в состояние "включено".
func onLed():
	led_mesh.visible=true
	ledState=1
	pass

# Функция `flashLed()` воспроизводит анимацию мигания LED и устанавливает состояние "включено".
func flashLed():
	led_anim.play("FLASH")
	ledState=1
	pass
