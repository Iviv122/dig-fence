extends Button
class_name Restart

func _pressed() -> void:
    get_tree().reload_current_scene()