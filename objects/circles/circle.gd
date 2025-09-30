extends Sprite2D
class_name Circle

@export var close_button : Button
@export var field : Field 

var digger : Digger
var X : int 
var Y : int

func destroy():
	queue_free()

func set_digger(dig:Digger) -> void:
	digger = dig
	digger.digged.connect(destroy)

