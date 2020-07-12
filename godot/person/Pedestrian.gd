extends Node2D

export var min_target_range = 16.0
export var has_mask = true
export var infected = true
export(NodePath) var path_resource
onready var person = $Person

var move_speed = 100
var patrol_points
var patrol_index = 0

func _ready():
	randomize()
	person.has_mask = has_mask
	person.infected = infected
	if path_resource:
		patrol_points = get_node(path_resource).curve.get_baked_points()
	
func _process(delta):
	if !path_resource || patrol_points.size() == 0:
		return
	var target = patrol_points[patrol_index]
	if person.position.distance_to(target) < 10.0:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	person.input_vector = (target - person.position).normalized() * move_speed
