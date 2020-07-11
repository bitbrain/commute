extends Node2D

onready var player = $Objects/People/Player

var input_vector = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit(0)
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	player.input_vector = input_vector

# RE-ENABLE TWITCH STREAM!
