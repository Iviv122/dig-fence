extends Tower
class_name Farm

@export var money_per_wave : int = 100
@export var money_effect : GPUParticles2D

func _ready():
	add_to_group("wave_end")

func wave_end():
	print("MONEY COMES NOW")
	PlayerInstance.add_money(money_per_wave)
	shoot_label()
	money_effect.restart()

func shoot_label():
	var l = Label.new()

	l.text = str(money_per_wave) + "$"
	l.add_theme_color_override("font_color",Color(0,1,0))

	l.top_level = true
	l.global_position = global_position

	var t =get_tree().create_tween()
	var pos = l.global_position+Vector2(0,-50)

	t.tween_property(l,"position",pos,1)

	add_child(l)

	await get_tree().create_timer(1).timeout
	l.queue_free()

func upgrade() -> void:
	summed_price += price
	PlayerInstance.substruct_money(price)

	price *= 1.5
	money_per_wave *= 1.5
	upgrade_num+=1


func shoot(_target : Enemy)->void:
	pass
func check() -> void:
	pass
func _process(_delta):
	pass
