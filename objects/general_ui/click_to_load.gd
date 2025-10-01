extends Node
class_name ClickToLoad

@export var scene : PackedScene

func _input(event):
    if event is InputEventKey or event is InputEventMouseButton:
        get_tree().change_scene_to_packed(scene)