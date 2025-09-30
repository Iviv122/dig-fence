extends Camera2D

@export var Speed: float = 1

@export var MaxZoom: int = 4

var dir: Vector2 = Vector2(0, 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		dir.x -= 1
	if event.is_action_released("left"):
		dir.x += 1
	if event.is_action_pressed("right"):
		dir.x += 1
	if event.is_action_released("right"):
		dir.x -= 1

	if event.is_action_pressed("up"):
		dir.y -= 1
	if event.is_action_released("up"):
		dir.y += 1
	if event.is_action_pressed("down"):
		dir.y += 1
	if event.is_action_released("down"):
		dir.y -= 1

	if event.is_action_pressed("zoomin"):
		zoom.x = min(zoom.x+1,MaxZoom)
		zoom.y = min(zoom.y+1,MaxZoom)
	if event.is_action_pressed("zoomout"):
		zoom.x -= 1 
		zoom.y -= 1

func _process(_delta: float) -> void:
	position += dir * Speed * _delta
	position = Vector2(clamp(position.x,limit_left+get_viewport_rect().size.x/2,limit_right-get_viewport_rect().size.x/2),clamp(position.y,limit_top+get_viewport_rect().size.y/2,limit_bottom-get_viewport_rect().size.y/2))

