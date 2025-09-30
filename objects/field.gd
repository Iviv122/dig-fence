extends Node2D
class_name Field 

@export var empty_tile : Tile

var width : int = 5
var depth : int = 0

var tile_width : int = 64 
var tile_height : int =  64 

var matrix : Array[Sprite2D] = []
var path : Array[Vector2] = []

var towers = {}


func _ready():
	add_line()
	add_line()
	add_line()
	add_line()

func dig():
	pass

func place():
	pass

# init pos is {0;0} so i need to offset it a bit
func add_line():

	for i in range(0,width):
		var t = Sprite2D.new()
		
		t.texture = empty_tile.texture
		t.scale = Vector2(2,2)
		t.global_position = global_position+Vector2(i*tile_width,depth*tile_height)
		
		matrix.append(t)
		add_child(t)

	depth += 1
