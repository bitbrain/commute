extends KinematicBody2D

export var ACCELERATION = 300
export var FRICTION = 450
export var MAX_SPEED = 60

export var infected = false setget set_infected
export var has_mask = true setget set_has_mask

export(Vector2) var direction = Vector2.UP

onready var particles = $Particles2D
onready var light = $Light2D
onready var sprite = $Sprite
onready var face_mask = $FaceMask
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

func _ready():
	animation_tree.active = true
	face_mask.visible = self.has_mask
	
	animation_tree.set("parameters/Idle/blend_position", direction.normalized())
	animation_tree.set("parameters/Walk/blend_position", direction.normalized())
	
	particles.visible = infected && !has_mask
	light.visible = infected && !has_mask

func is_infected():
	return infected
	
func has_mask():
	return has_mask
	
func set_infected(inf):
	infected = inf
	if particles != null && light != null:
		particles.visible = infected && !has_mask
		light.visible = infected && !has_mask

func set_has_mask(has):
	has_mask = has
	if face_mask != null:
		face_mask.visible = has_mask
		particles.visible = infected && !has_mask
		light.visible = infected && !has_mask
		
func _process(delta):
	move_state(delta)

func move_state(delta):
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_state.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
