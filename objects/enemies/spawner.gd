extends Node 
class_name Spawner

@export var digger : Digger
@export var field : Field 
@export var line : Line2D 

@export var enemy : PackedScene
var wave = 0

func _ready():
	field.new_line.connect(start_wave)

func stop_wave():
	digger.show()

func start_wave():
	digger.hide()
	await  get_tree().process_frame
	spawn()

func spawn():
	var n = line.points.size()
	
	var e : Enemy = enemy.instantiate()

	e.set_line(line)
	var p = line.points[n-1]

	e.global_position = p
	add_child(e)
