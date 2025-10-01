extends GPUParticles2D
class_name DieOnEnd

func _ready():
    emitting = true
    await get_tree().create_timer(lifetime).timeout
    queue_free()