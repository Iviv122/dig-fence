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
	if PlayerInstance.money >= tower.price:
		if !used:
			tower.upgrade()
			used = true
			queue_free()

func _draw():
	print(tower.radius)
	draw_circle(Vector2.ZERO, tower.radius, Color(0.2, 0.8, 1.0, 0.3)) # Light blue, semi-transparent

func set_buttons():
	if tower.upgrade_num <= tower.max_upgrade: 
		upgrade_button.pressed.connect(
			func():
				upgrade()
		)
	else:
		upgrade_button.queue_free()
		upgrade_button = null

	close_button.pressed.connect(
		func():
			queue_free()
	)
	sell_button.pressed.connect(
		func():
			sell()
	)
	

func update():
	if  upgrade_button != null:
		upgrade_button.text = str(tower.price)	
		if PlayerInstance.money >= tower.price:
			upgrade_button.disabled = false
		else:
			upgrade_button.disabled = true 


	sell_button.text = str(tower.summed_price)

func _ready():
	tower = field.towers[Vector2(X, Y)]
	PlayerInstance.money_change.connect(update)
	
	set_buttons()
	update()
