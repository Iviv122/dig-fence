extends Node2D
class_name Field

@export var entry_portal: PackedScene
@export var path_line: Line2D

var width: int = 5
var depth: int = 0

var tile_width: int = 64
var tile_height: int = 64
var matrix: Array[Tile] = []

var path: Array[Vector2] = []
var path_head: Vector2


var towers = {}

var dirs = [
	Vector2(-1, 0), # left
	Vector2(1, 0), # right
	Vector2(0, 1) # down
]

func _ready():
	add_line()
	add_line()
	add_line()
	add_line()
	continue_tiles()
	print("total tiles:", matrix.size())

	path_head.x = ceil(width / 2)
	place_path(path_head.x, path_head.y)
	place_portal(path_head.x)

# left, right,down
func dig(x: int, y: int):
	if x < 0 or x > width:
		return ;
	if y < 0 or y > depth:
		return ;
	if matrix[y * width + x] is PathTile:
		return ;

	var nx = x - path_head.x
	var ny = y - path_head.y

	# make sure we won't go up or will have separated paths
	if Vector2(nx, ny) not in dirs:
		return ;
	
	path_head.x = x
	path_head.y = y

	place_path(x, y)


# for towers
func place():
	pass

func place_path(x, y):
	if matrix[y * width + x] is ContinueTile:
		replace_add_line()
		add_continue_tiles()
	matrix[y * width + x].queue_free()
	
	# add path tile
	var t = PathTile.new()
		
	t.global_position = global_position + Vector2(x * tile_width, y * tile_width)
	matrix[y * width + x] = t
	path.push_back(t.global_position)
	path_line.add_point(t.global_position)
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

		print(x ," ", depth)
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
