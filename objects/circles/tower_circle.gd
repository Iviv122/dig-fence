extends Circle
class_name TowerCircle

@export var sell_button: Button
@export var upgrade_button: Button

var tower: Tower
var used = false

func sell():
	if !used:
		tower.sell()
		used = true
		queue_free()

func upgrade():
	if !used:
		tower.upgrade()
		used = true
		queue_free()

func _draw():
	draw_circle(Vector2.ZERO, tower.radius, Color(0.2, 0.8, 1.0, 0.3)) # Light blue, semi-transparent

func set_buttons():
	close_button.pressed.connect(
		func():
			queue_free()
	)
	sell_button.pressed.connect(
		func():
			sell()
	)
	upgrade_button.pressed.connect(
		func():
			upgrade()
	)

func update():
	
	if PlayerInstance.money >= tower.price:
		upgrade_button.disabled = false
	else:
		upgrade_button.disabled = true 
	upgrade_button.text = str(tower.price)	
	sell_button.text = str(tower.summed_price)

func _ready():
	tower = field.towers[Vector2(X, Y)]
	PlayerInstance.money_change.connect(update)
	update()
	set_buttons()