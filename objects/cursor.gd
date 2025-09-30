extends Sprite2D 
class_name Cursor

@export var place_particle : PackedScene
@export var tile_size : int = 64

var X : int = 1
var Y : int = 1

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		X = (pos.x + tile_size/2) / tile_size 
		Y = (pos.y + tile_size/2) / tile_size 
		global_position = Vector2(X*tile_size,Y*tile_size)


func _ready():
	global_position = Vector2(X*tile_size,Y*tile_size) 