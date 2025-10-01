extends Node2D

@export var speed : float

func _process(delta):
    rotation_degrees += speed*delta