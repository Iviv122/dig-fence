extends Circle 
class_name SelectionCircle

@export var buttons: Array[Button]
@export var towers: Array[PackedScene]
@export var options : Array[Node]

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
