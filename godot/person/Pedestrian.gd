extends Node2D

enum {
	IDLE,
	WALK
}

export var min_target_range = 16.0
export var has_mask = true

onready var wandererController = $Person/WandererController
onready var state = IDLE
onready var person = $Person

func _ready():
	randomize()
	person.has_mask = has_mask
	wandererController.update_target_position()
	next_state()
	
func next_state():
	state = pick_random_state([IDLE, WALK])
	wandererController.start_timer(rand_range(3, 4))
	
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
func _process(delta):
	match state:
		IDLE:
			person.input_vector = Vector2.ZERO
			if wandererController.get_time_left() == 0:
				next_state()
		WALK:
			person.input_vector = person.global_position.direction_to(wandererController.target_position)
			if wandererController.get_time_left() == 0:
				next_state()
			if person.global_position.distance_to(wandererController.target_position) <= min_target_range:
				next_state()
			if person.velocity.length() < 1.0:
				next_state()
