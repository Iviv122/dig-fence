extends Label
class_name PulsatingText

@export var speed: float = 2.0
@export var min_alpha: float = 0.3

var time_passed: float = 0.0

func _process(delta: float) -> void:
	time_passed += delta
	var alpha = min_alpha + (1.0 - min_alpha) * 0.5 * (1.0 + sin(time_passed * speed))
	
	var current_color = modulate
	current_color.a = alpha
	modulate = current_color
