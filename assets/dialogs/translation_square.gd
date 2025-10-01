extends Sprite2D 
class_name TranslationSquare
var fade_duration = 1.0

@export var next_scene : PackedScene
@export var dialog :  Dialog 

func _ready():
	fade_out()
	if dialog != null:
		dialog.ended.connect(fade_in)

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, fade_duration)
	tween.play()
	await tween.finished
	tween.kill()

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, fade_duration)
	tween.play()
	await tween.finished
	tween.kill()
	if next_scene != null:
		get_tree().call_group("load_scene","load_scene",next_scene)
