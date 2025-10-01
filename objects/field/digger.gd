extends Sprite2D
class_name Digger

@export var field: Field

@export var left_button: Button
@export var right_button: Button
@export var button_button: Button

@export var path_line: Line2D

var x: int
var y: int

var dirs = [
	Vector2(-1, 0), # left
	Vector2(1, 0), # right
	Vector2(0, 1) # down
]
enum DirType {
	
	LEFT,
	RIGHT,
	DOWN,
}

signal digged()

func _ready():
	x = ceil(field.width / 2)
	
	field.place_path(x, y)
	field.place_portal(x)
	digged.emit()
	global_position = Vector2(x * field.tile_width, 0)
	path_line.add_point(global_position)
	
	left_button.pressed.connect(func(): dig(DirType.LEFT))
	right_button.pressed.connect(func(): dig(DirType.RIGHT))
	button_button.pressed.connect(func(): dig(DirType.DOWN))
	field.update.connect(hide_button)

func show_buttons():
	left_button.show()
	button_button.show()
	right_button.show()

func hide_button():
	show_buttons()

	if x - 1 < 0:
		left_button.hide()
	if x + 1 > field.width - 1:
		right_button.hide()

	if Vector2(x - 1, y) in field.towers and left_button.visible:
		left_button.hide()
	if Vector2(x, y + 1) in field.towers and button_button.visible:
		button_button.hide()
	if Vector2(x + 1, y) in field.towers and right_button.visible:
		right_button.hide()

	if field.get_tile(x-1,y)  is PathTile and left_button.visible:
		left_button.hide()
	if field.get_tile(x+1,y) is PathTile and right_button.visible:
		right_button.hide()
	

# left, right,down
func dig(dir: DirType):
	x += dirs[dir].x
	y += dirs[dir].y


	field.place_path(x, y)
	digged.emit()
	hide_button()
	global_position = Vector2(x * field.tile_width, y * field.tile_height)

	path_line.add_point(global_position)