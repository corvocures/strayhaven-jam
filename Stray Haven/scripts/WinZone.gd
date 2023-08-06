extends Area2D

func _on_WinZone_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer.stop()
		$GameOver.play()
		$CanvasLayer/UI/YouLost.visible = true
