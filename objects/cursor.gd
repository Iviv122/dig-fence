extends Sprite2D 
class_name Cursor

@export var place_particle : PackedScene
@export var tile_size : int = 64
@export var field : Field 

var X : int = 1
var Y : int = 1

func _input(event):
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		X = (pos.x + tile_size/2) / tile_size 
		Y = (pos.y + tile_size/2) / tile_size 

		X = clamp(X,0,field.width-1)		
		Y = clamp(Y,0,field.depth-1)

		global_position = Vector2(X*tile_size,Y*tile_size)


func _ready():
	global_position = Vector2(X*tile_size,Y*tile_size) 
