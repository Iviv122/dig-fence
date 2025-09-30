extends Node2D
class_name Field

@export var entry_portal: PackedScene

var width: int = 5
var depth: int = 0

var tile_width: int = 64
var tile_height: int = 64
var matrix: Array[Tile] = []
var towers = {}

signal new_line()

func _ready():
	add_line()
	add_line()
	add_line()
	add_line()
	continue_tiles()

func place(x,y,tower:PackedScene):
	if matrix[y * width + x] is PathTile:
		return;
	
	var t : Tower = tower.instantiate()
	t.global_position = global_position + Vector2(x * tile_width, y * tile_width)
	towers[Vector2(x,y)] = t 
	
	add_child(t)

func place_path(x, y):
	if matrix[y * width + x] is ContinueTile:
		replace_add_line()
		add_continue_tiles()
		new_line.emit()
	
	matrix[y * width + x].queue_free()

	if Vector2(x,y) in towers:
		towers[Vector2(x,y)].queue_free()
		towers.erase(Vector2(x,y))

	# add path tile
	var t = PathTile.new()
		
	t.global_position = global_position + Vector2(x * tile_width, y * tile_width)
	matrix[y * width + x] = t
	add_child(t)

func place_portal(x):
	var portal: Sprite2D = entry_portal.instantiate()
	portal.global_position = matrix[x].global_position
	add_child(portal)

# init pos is {0;0} so i need to offset it a bit
func add_line():
	for x in range(0, width):
		var t = EmptyTile.new()
		
		t.global_position = global_position + Vector2(x * tile_width, depth * tile_height)

		matrix.append(t)
		add_child(t)

	depth += 1

func continue_tiles():
	for i in range(0, width):
		var t = ContinueTile.new()
		
		t.global_position = global_position + Vector2(i * tile_width, depth * tile_height)
		
		matrix.append(t)
		add_child(t)
	depth += 1

func replace_add_line():
	var d = depth-1
	for x in range(0, width):
		
		if matrix[d*width+x] is PathTile:
			continue
		matrix[d*width+x].queue_free()
		var t = EmptyTile.new()
		
		t.global_position = global_position + Vector2(x * tile_width, d * tile_height)
		matrix[d*width+x] = t
		add_child(t)

func add_continue_tiles():
	for i in range(0, width):
		var t = ContinueTile.new()
		
		t.global_position = global_position + Vector2(i * tile_width, depth * tile_height)
		
		matrix.append(t)
		add_child(t)
	depth += 1
