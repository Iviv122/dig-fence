extends Button
class_name ClickToClose

@export var obj : Node

func _pressed() -> void:
    obj.queue_free()