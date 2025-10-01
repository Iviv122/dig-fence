extends Node 
class_name Spawner

@export var digger : Digger
@export var field : Field 
@export var line : Line2D 

@export var enemy : Array[PackedScene]

var wave = 0
var wave_material = 0


func _ready():
	field.new_line.connect(start_wave)

func stop_wave():
	print("wave_end")
	wave +=1
	digger.show()
	get_tree().call_group("wave_end","wave_end")

func start_wave():
	digger.hide()
	
	wave_material = (wave+3)*(wave+3)
	await  get_tree().process_frame
	spawn()

func spawn():
	if wave_material > 0:
		var n = line.points.size()

		var e : Enemy
		if wave >= enemy.size():	
			e = enemy.pick_random().instantiate()
		else:
			e = enemy[wave].instantiate() 

		e.set_line(line)
		var p = line.points[n-1]

		e.global_position = p
		add_child(e)
		await get_tree().create_timer(0.1).timeout
		spawn()
		wave_material-=1
	else:
		stop_wave()
