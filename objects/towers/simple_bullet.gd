extends Sprite2D
class_name SimpleBullet

var damage: float = 0
var speed: float
var e: Enemy


func init(dam: float, s: float, enemy: Enemy):
	damage = dam
	speed = s
	e = enemy


func _process(delta: float) -> void:
	if e == null:
		queue_free()
		return
	
	var distance_to_enemy = (e.global_position - global_position).length()
	if distance_to_enemy <= 0.1:
		e.deal_damage(damage)
		queue_free()
	else:
		global_position = global_position.move_toward(e.global_position, speed * delta)