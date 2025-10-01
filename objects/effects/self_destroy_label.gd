extends Label
class_name SelfDestroyLabel

func destroy(time : float):
	await get_tree().create_timer(time).timeout
	queue_free()
