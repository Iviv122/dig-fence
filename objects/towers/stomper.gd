extends Tower
class_name Stomper

@export var stomp_effect : PackedScene
@export var damage_type : Enemy.DamageType

func check()->void:
	if reload_time <= 0:
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

		if n>0: 
			for i in result:
				i.collider.deal_damage(damage,damage_type)
			add_child(stomp_effect.instantiate())
			reload_time = 1	


func _process(delta):
	reload_time -= delta*attackspeed
	check()
