extends Node2D 
class_name MistakeShaker

@export var curv : CurveTexture
@export var speed : float
@export var amplify : float

var time = 10

func _ready() -> void:
	PlayerInstance.health_change.connect(shake)

func shake() -> void:
	time = 0

func _process(delta: float) -> void:
	time += delta*speed
	position.x = curv.curve.sample(time)*amplify
	position.y = curv.curve.sample(time)*amplify
