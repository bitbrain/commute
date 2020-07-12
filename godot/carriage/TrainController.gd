extends Node

const MAX_TRAIN_DISTANCE = 10000
const TRAIN_WAIT_DELAY = 7.0
const INITIAL_TRAIN_ARRIVAL_TIME = 2.0
const TRAIN_AWAY_DELAY = 60.0
const TRAIN_TRAVEL_TIME = 13.0

export(NodePath) var train_path

onready var train_arrive_tween = $TrainArriveTween
onready var train_leave_tween = $TrainLeaveTween
onready var train_sounds = $TrainSounds

var train

var input_vector = Vector2.ZERO
var train_stop_position_x = 0.0

func _ready():
	train = get_node(train_path)
	train_stop_position_x = train.position.x
	train.position.x = -MAX_TRAIN_DISTANCE
	train_arrive_tween.interpolate_property(train, "position:x", train.position.x, train_stop_position_x, TRAIN_TRAVEL_TIME, Tween.TRANS_CUBIC, Tween.EASE_OUT, INITIAL_TRAIN_ARRIVAL_TIME)
	train_arrive_tween.start()

func _on_TrainArriveTween_tween_completed(object, key):
	train_arrive_tween.stop_all()
	train_leave_tween.interpolate_property(train, "position:x", train.position.x, MAX_TRAIN_DISTANCE, TRAIN_TRAVEL_TIME, Tween.TRANS_CUBIC, Tween.EASE_IN, TRAIN_WAIT_DELAY)
	train_leave_tween.start()


func _on_TrainLeaveTween_tween_completed(object, key):
	train_leave_tween.stop_all()
	train.position.x = -MAX_TRAIN_DISTANCE
	train_arrive_tween.interpolate_property(train, "position:x", train.position.x, train_stop_position_x, TRAIN_TRAVEL_TIME, Tween.TRANS_CUBIC, Tween.EASE_OUT, TRAIN_AWAY_DELAY)
	train_arrive_tween.start()


func _on_TrainArriveTween_tween_started(object, key):
	train_sounds.play()
