extends CanvasLayer
class_name LoseCanvas


func is_end():
	if PlayerInstance.health <= 0:
		show()

func _ready():
	hide()
	PlayerInstance.health_change.connect(is_end)