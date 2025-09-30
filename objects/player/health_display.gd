extends Label 
class_name HealthDisplay

func update()->void:
	text = str(PlayerInstance.health) 

func _ready() -> void:
	PlayerInstance.health_change.connect(update)	
	update()
