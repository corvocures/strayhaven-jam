extends PathFollow2D

export var speed = 60

func _physics_process(delta):
	offset += speed * delta
	if unit_offset >= 1:
		reached_end()

func reached_end():
	queue_free()
