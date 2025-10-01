extends Tile 
class_name Tower 

@export var price : int = 100
@export var radius : float = 5
@export var bullet_speed : float = 5
@export var attackspeed : float = 0.1 # seconds for single attack
@export var damage : float = 1

@export var projectile : PackedScene #not necessary

var X :int
var Y :int
var field : Field

var summed_price = price
var reload_time = 0 

signal sold(v : Vector2)

func sell() ->void:
	sold.emit(Vector2(X,Y))
	PlayerInstance.add_money(summed_price)

func upgrade()->void:

	summed_price += price*1.5
	PlayerInstance.substruct_money(price*1.5)
	
	price*=1.5
	radius*=1.5
	attackspeed*=1.5
	damage*=1.5


func shoot(target : Enemy)->void:
	if reload_time <= 0:
		var p : SimpleBullet = projectile.instantiate()
		
		p.global_position = global_position
		p.init(damage,bullet_speed,target)

		get_parent().add_child(p)
		reload_time = 1 


func check() -> void:
	var space_state = get_world_2d().direct_space_state

	var circle_shape = CircleShape2D.new()
	circle_shape.radius = radius 

	transform.origin = global_position 

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = circle_shape
	query.transform = transform
	query.collide_with_areas = true 

	var result = space_state.intersect_shape(query) 

	var n = result.size()

	if n > 0:
		var collider = result[0].collider

		var direction = (collider.global_position - global_position).angle()
		rotation = lerp_angle(rotation, direction, 0.1)
		shoot(collider)

func _process(delta):
	reload_time -= delta*attackspeed
	check()
