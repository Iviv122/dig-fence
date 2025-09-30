extends Area2D 
class_name Enemy 

@export var line : Line2D
@export var speed : float

var index

func set_line(l : Line2D):
	line = l
	index = line.points.size()-1

func die():
	queue_free()

func suicide():
	PlayerInstance.substruct_health(1)
	die()

func _process(delta: float) -> void:
	var len = (global_position-line.points[index-1]).length()
	
	if len > 0.1:
		global_position += (line.points[index-1]-global_position).normalized()*speed*delta
	else:
		index-=1
		if index <= 0:
			suicide()
