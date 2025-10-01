extends Circle 
class_name SelectionCircle

@export var buttons: Array[Button]
@export var towers: Array[PackedScene]
@export var prices: Array[int] 

var used = false

func spawn(tower : PackedScene) -> void:
	if !used:
		field.place(X,Y,tower)
		used = true
		queue_free()

func update():
	for i in range(min(buttons.size(), towers.size())):
		if PlayerInstance.money >= prices[i]:
			buttons[i].disabled = false 
		else:
			buttons[i].disabled =true 

func set_buttons():

	close_button.pressed.connect(
		func():
			queue_free()
	)

	for i in range(min(buttons.size(), towers.size())):

		
		buttons[i].text = str(prices[i])
		buttons[i].pressed.connect(
			func():
				if !used:
					spawn(towers[i])
					PlayerInstance.substruct_money(prices[i])
		)


func _ready() -> void:
	PlayerInstance.money_change.connect(update)
	update()
	set_buttons()

	