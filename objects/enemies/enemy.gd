extends Area2D
class_name Enemy

@export var line: Line2D
@export var speed: float
@export var health: float
@export var damagetype: DamageType
@export var money_per_enemy: int = 15

var index

signal health_changed()

func set_line(l: Line2D):
	line = l
	index = line.points.size() - 1

func die():
	PlayerInstance.add_money(money_per_enemy)
	shot_label()
	queue_free()

func shot_label():
	var l = SelfDestroyLabel.new()

	l.text = str(money_per_enemy)
	l.add_theme_color_override("font_color", Color(0, 1, 0))

	l.top_level = true
	l.global_position = global_position

	var t = get_tree().create_tween()
	var pos = l.global_position + Vector2(0, -50)

	t.tween_property(l, "position", pos, 1)

	get_tree().root.add_child(l)
	l.destroy(1)

func suicide():
	PlayerInstance.substruct_health(1)
	die()

func deal_damage(a: float, incoming_type: DamageType):
	var multiplier := 1.0
	
	match incoming_type:
		DamageType.Blue:
			match damagetype:
				DamageType.Blue: multiplier = 0.7
				DamageType.Yellow: multiplier = 1.5
				DamageType.Green: multiplier = 0.2

		DamageType.Yellow:
			match damagetype:
				DamageType.Yellow: multiplier = 0.7
				DamageType.Green: multiplier = 1.5
				DamageType.Blue: multiplier = 0.2

		DamageType.Green:
			match damagetype:
				DamageType.Green: multiplier = 0.7
				DamageType.Blue: multiplier = 1.5
				DamageType.Yellow: multiplier = 0.2

	if multiplier == 0.7:
		print("ineffective")
	var final_damage = a * multiplier
	health -= final_damage
	health_changed.emit()

	if health <= 0:
		die()

var progress = 0

func _process(delta: float) -> void:
	
	if progress >= 1:
		index -= 1
		progress = 0
		if index <= 0:
			suicide()
	else:
		global_position = line.points[index].lerp(line.points[index-1],progress)

	progress += delta * speed


enum DamageType {
	Blue,
	Yellow,
	Green
}
