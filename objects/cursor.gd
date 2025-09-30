extends Sprite2D 
class_name Cursor

@export var selection_circle: PackedScene
@export var tile_size : int = 64
@export var field : Field 
@export var digger : Digger

var X : int = 1
var Y : int = 1

var circle : SelectionCircle

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		if X!=-1 and Y!=-1: 
			var tile =  field.matrix[X+field.width*Y]
			if  tile is not PathTile and tile is not ContinueTile and tile is not Tower:
				
				if circle!=null:
					circle.queue_free()

				circle = selection_circle.instantiate()

				circle.global_position = Vector2(X*tile_size,Y*tile_size)
				circle.X = X
				circle.Y = Y
				circle.field = field
				circle.set_digger(digger)

				get_tree().root.add_child(circle)
			if tile is Tower:
				pass
		else:
			if circle!=null:
				circle.queue_free()
	
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		X = (pos.x + tile_size/2) / tile_size 
		Y = (pos.y + tile_size/2) / tile_size 

		if X < 0 or X > field.width or Y < 0 or Y >field.depth:
			X = -1
			Y = -1
			global_position = Vector2(-1000,-1000)
		else:
			X = clamp(X,0,field.width-1)		
			Y = clamp(Y,0,field.depth-1)

			global_position = Vector2(X*tile_size,Y*tile_size)


func _ready():

	global_position = Vector2(X*tile_size,Y*tile_size) 
