extends Control

const FRAMES = 7

onready var sprite = $Sprite

func _ready():
	sprite.visible = false

func set_health_percentage(health_percentage):
	if sprite != null:
		sprite.visible = health_percentage != 1.0
		sprite.frame = remap_range(100 - health_percentage * 105, 0, 100, 0, 6)

func remap_range(input:int, minInput:int, maxInput:int, minOutput:int, maxOutput:int):
	return int(float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput)
