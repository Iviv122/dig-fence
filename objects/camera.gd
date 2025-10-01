extends Camera2D

@export var Speed: float = 1

@export var MaxZoom: int = 4

var dir: Vector2 = Vector2(0, 0)

var dragging: bool = false
var drag_start_mouse_pos: Vector2
var drag_start_camera_pos: Vector2

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

	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_MIDDLE:
			if mouse_event.pressed:
				dragging = true
				drag_start_mouse_pos = get_viewport().get_mouse_position()
				drag_start_camera_pos = position
			else:
				dragging = false

func _process(delta: float) -> void:
	position += dir * Speed * delta

	if dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var off = (drag_start_mouse_pos - current_mouse_pos) * zoom
		position = drag_start_camera_pos + off 

	var half_viewport = get_viewport_rect().size / 2 * zoom
	position.x = clamp(position.x, limit_left + half_viewport.x, limit_right - half_viewport.x)
	position.y = clamp(position.y, limit_top + half_viewport.y, limit_bottom - half_viewport.y)

