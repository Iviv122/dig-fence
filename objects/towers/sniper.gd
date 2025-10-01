extends Tower 
class_name Sniper 

func upgrade() -> void:
	if upgrade_num <= max_upgrade:

		summed_price += price
		PlayerInstance.substruct_money(price)

		price *= 1.5
		radius *= 1.5
		attackspeed *= 1.5 
		damage *= 1.5
		upgrade_num +=1


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
