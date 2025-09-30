extends Button 
class_name MoneyDisplay

func update()->void:
	text = str(PlayerInstance.money) + "$" 

func _ready() -> void:
	PlayerInstance.money_change.connect(update)
	update()	