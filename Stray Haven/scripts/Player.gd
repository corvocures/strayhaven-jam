extends KinematicBody2D

onready var jump_sound = $JumpSound
onready var hurt_sound = $HurtSound
onready var ray = $RayCast2D
onready var camera = $Camera2D

var dead = false
var can_move = true

var grid_size = 16
var inputs = {
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
	"ui_left": Vector2.LEFT,
	"ui_right": Vector2.RIGHT
}

func _ready():
	Global.player = self
	global_position = Global.save_pos
	dead = false
	$Sprite.rotation_degrees = 0
	$Sprite.modulate = Color( 1, 1, 1, 1 )
	can_move = true

func _exit_tree():
	Global.player = null
	dead = true
	can_move = false

func _unhandled_input(event):
	if Global.player != null:
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				if $Tween.is_active() == false:
					move(dir)

func move(dir):
	var vector_pos = inputs[dir] * grid_size
	if vector_pos == Vector2( -16, 0 ):
		$Sprite.rotation_degrees = -90
	if vector_pos == Vector2( 16, 0 ):
		$Sprite.rotation_degrees = 90
	if vector_pos == Vector2( 0, -16 ):
		$Sprite.rotation_degrees = 0
	if vector_pos == Vector2( 0, 16 ):
		$Sprite.rotation_degrees = 180
	ray.cast_to = vector_pos
	ray.force_raycast_update()
	$Tween.interpolate_property(
		self, "position", position, position + vector_pos, 0.125, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	if !ray.is_colliding() && can_move == true:
		jump_sound.play()
		$Tween.start()

func death():
	if dead == false && Global.player != null:
		dead = true
		hurt_sound.play()
		can_move = false
		Global.player = null
		Global.lives -= 1
		$Sprite.modulate = Color( 0.5, 0, 0, 1 )
		yield(get_tree().create_timer(1), "timeout")
		#get_tree().reload_current_scene()
		restart()

func restart():
	if Global.lives > 0:
		global_position = Global.save_pos
		$Sprite.rotation_degrees = 0
		$Sprite.modulate = Color( 1, 1, 1, 1 )
		Global.player = self
		global_position = Global.save_pos
		dead = false
		can_move = true

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		death()
