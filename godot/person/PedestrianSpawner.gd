extends Node2D

export(NodePath) var target_parent_node
export(int) var pedestrian_count = 10
export(float) var facemask_probability = 0.2

onready var Pedestrian = preload("res://person/Pedestrian.tscn")
onready var shape = $CollisionShape2D

func _ready():
	randomize()
	var parent_node = get_node(target_parent_node)
	for i in range(pedestrian_count):
		var pedestrian = create_new_pedestrian()
		pedestrian.position = get_random_position()
		pedestrian.has_mask = randf() <= facemask_probability
		parent_node.add_child(pedestrian)
		

func get_random_position():
	var extents = shape.shape.extents
	var randomX = shape.position.x + rand_range(0.0, extents.x)
	var randomY = shape.position.y + rand_range(0.0, extents.y)
	return Vector2(randomX, randomY)

func create_new_pedestrian():
	return Pedestrian.instance()
