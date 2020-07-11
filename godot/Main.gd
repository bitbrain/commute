extends Node2D

const MAX_TRAIN_DISTANCE = 5000
const TRAIN_WAIT_DELAY = 10.0

onready var player = $Objects/People/Player
onready var train = $Objects/Train
onready var train_arrive_tween = $TrainArriveTween
onready var train_leave_tween = $TrainLeaveTween

var input_vector = Vector2.ZERO
var train_stop_position_x = 0.0

func _ready():
	train_stop_position_x = train.position.x
	train.position.x = -MAX_TRAIN_DISTANCE
	train_arrive_tween.interpolate_property(train, "position:x", train.position.x, train_stop_position_x, 6.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, TRAIN_WAIT_DELAY)
	train_arrive_tween.start()
	

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit(0)
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	player.input_vector = input_vector


func _on_TrainArriveTween_tween_completed(object, key):
	train_arrive_tween.stop_all()
	train_leave_tween.interpolate_property(train, "position:x", train.position.x, MAX_TRAIN_DISTANCE, 8.0, Tween.TRANS_CUBIC, Tween.EASE_IN, TRAIN_WAIT_DELAY)
	train_leave_tween.start()


func _on_TrainLeaveTween_tween_completed(object, key):
	train_leave_tween.stop_all()
	train.position.x = -MAX_TRAIN_DISTANCE
	train_arrive_tween.interpolate_property(train, "position:x", train.position.x, train_stop_position_x, 8.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, TRAIN_WAIT_DELAY)
	train_arrive_tween.start()
