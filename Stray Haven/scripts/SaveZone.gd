extends Area2D

var saved = false

func _on_SaveZone_body_entered(body):
	if body.is_in_group("player") and saved == false:
		Global.save_pos -= Vector2( 0, 128 )
		saved = true
		queue_free()
