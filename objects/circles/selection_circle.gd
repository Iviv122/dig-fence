extends Sprite2D
class_name SelectionCircle

@export var buttons: Array[Button]
@export var towers: Array[PackedScene]
@export var options : Array[Node]

@export var close_button : Button

@export var field : Field 

var digger : Digger

var X : int 
var Y : int

var button_tower_map: Dictionary = {}

func destroy():
	queue_free()

func set_digger(dig:Digger) -> void:
	digger = dig
	digger.digged.connect(destroy)

func spawn(tower : PackedScene) -> void:
	field.place(X,Y,tower)
	queue_free()

func _ready() -> void:

	close_button.pressed.connect(
		func():
			queue_free()
	)

	for i in range(min(buttons.size(), towers.size())):

		buttons[i].pressed.connect(
			func():
				spawn(towers[i])
		)
