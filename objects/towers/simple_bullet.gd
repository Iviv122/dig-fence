extends Sprite2D 
class_name SimpleBullet

@export var bullet_radius : float = 32

var max_dist :float = 1000
var damage :float = 0
var dir : Vector2 
var speed : float
var e : Enemy

func init(dist : float, dam : float,s : float,enemy : Enemy):
	max_dist = dist +0.2
	damage = dam 
	speed = s
	e = enemy

func _process(_delta: float) -> void:
	if e == null:
		queue_free()
		return;
	var l = (e.global_position-global_position).length()
	if l <= 0.5:
		e.deal_damage(damage)		
		queue_free()
	else:
		var x = move_toward(global_position.x,e.global_position.x,speed)
		var y = move_toward(global_position.y,e.global_position.y,speed)
		
		global_position = Vector2(x,y)
		
