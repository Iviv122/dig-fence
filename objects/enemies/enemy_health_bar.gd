extends ProgressBar
class_name EnemyHealthBar 

@export var enemy : Enemy 

func update():
	value = enemy.health


func _ready():
	min_value = 0
	max_value = enemy.health
	update()
	enemy.health_changed.connect(update)