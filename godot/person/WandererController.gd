extends Node2D

export(int) var wander_range = 48.0

onready var target_position = global_position
onready var timer = $Timer

var target_vector = Vector2.ZERO

func ready():
	randomize()

func get_time_left():
	return timer.time_left

func start_timer(duration):
	timer.start(duration)

func update_target_position():
	target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = global_position + target_vector

func _on_Timer_timeout():
	update_target_position()
