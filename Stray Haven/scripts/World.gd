extends Node2D

var do_once = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/Menu.tscn")

func _process(_delta):
	if Global.lives <= 0 && do_once == false:
		do_once = true
		$AudioStreamPlayer.stop()
		$GameOver.play()
		$CanvasLayer/UI/YouLost.visible = true

func _on_WinZone_body_entered(body):
	if body.is_in_group("player") && do_once == false:
		do_once = true
		Global.win = true
		Global.player.can_move = false
		$AudioStreamPlayer.stop()
		$Win.play()
		$CanvasLayer/UI/YouWin.visible = true
