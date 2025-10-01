extends Sprite2D
class_name SimpleBullet

var damage: float = 0
var speed: float
var e: Enemy
@export var damagetype : Enemy.DamageType

var init_pos : Vector2

var progress : float = 0

func init(dam: float, s: float, enemy: Enemy):
	damage = dam
	speed = s
	e = enemy
	init_pos =  global_position


func _process(delta: float) -> void:
	if e == null:
		queue_free()
		return
	
	var distance_to_enemy = (e.global_position - global_position).length()
	
	if distance_to_enemy <= 0.5:
		e.deal_damage(damage,damagetype)
		queue_free()
	else:
		global_position = init_pos.move_toward(e.global_position, progress)

	progress += delta*speed
