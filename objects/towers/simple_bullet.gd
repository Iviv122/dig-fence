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

func _process(delta: float) -> void:
	var l = (e.global_position-global_position).length()
	if l <= 0.5:
		e.deal_damage(damage)		
		queue_free()
	else:
		global_position.x=move_toward(global_position.x,e.global_position.x,speed)
		global_position.y=move_toward(global_position.y,e.global_position.y,speed)

func collide() ->void:
	var space_state = get_world_2d().direct_space_state

	var circle_shape = CircleShape2D.new()
	circle_shape.radius = bullet_radius 

	var transform = Transform2D()
	transform.origin = global_position 

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = circle_shape
	query.transform = transform
	query.collide_with_areas = true 

	var result = space_state.intersect_shape(query) 

	var n = result.size()