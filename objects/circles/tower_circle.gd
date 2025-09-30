extends Circle
class_name TowerCircle

@export var sell_button: Button
@export var upgrade_button: Button

var tower: Tower

func sell():
	tower.sell()
	queue_free()

func upgrade():
	tower.upgrade()
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, tower.radius, Color(0.2, 0.8, 1.0, 0.3)) # Light blue, semi-transparent

func _ready():
	tower = field.towers[Vector2(X, Y)]
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
