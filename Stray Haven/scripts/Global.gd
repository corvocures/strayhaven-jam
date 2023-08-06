extends Node

var node_creation_parent = null
var player = null
var save_pos = Vector2()
var lives = 3
var try_again = false
var win = false

func _ready():
	save_pos = Vector2( 64, 120 )
	lives = 3

func _process(_delta):
	if lives <= 0:
		lost()
	if win == true:
		win()

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func lost():
	if Input.is_action_pressed("ui_accept"):
		reload()

func win():
	if Input.is_action_pressed("ui_accept"):
		reload()

func reload():
	save_pos = Vector2( 64, 120 )
	lives = 3
	try_again = false
	win = false
	get_tree().reload_current_scene()
