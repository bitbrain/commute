extends KinematicBody2D

const HEALTH_INFECTION_THRESHOLD = 80.0

export var ACCELERATION = 300
export var FRICTION = 450
export var MAX_SPEED = 70

export var health = 100.0
export var infected = false
export var has_mask = true setget set_has_mask

export(Vector2) var direction = Vector2.UP

onready var sprite = $Sprite
onready var face_mask = $FaceMask
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var velocity = Vector2.ZERO
var collisions = []
var input_vector = Vector2.ZERO

func _ready():
	animation_tree.active = true
	face_mask.visible = self.has_mask
	#var material = sprite.material as ShaderMaterial
	#material.set_shader_param("health", self.health)
	#sprite.material = material.duplicate()
	if infected:
		$DeathTimer.start()
	
	animation_tree.set("parameters/Idle/blend_position", direction.normalized())
	animation_tree.set("parameters/Walk/blend_position", direction.normalized())

func set_has_mask(has):
	has_mask = has
	if face_mask != null:
		face_mask.visible = has_mask
		
func _process(delta):
	move_state(delta)
	#for area in collisions:
	#	var other_player = area.get_parent()
	#	if other_player.infected && other_player.health <= HEALTH_INFECTION_THRESHOLD:
	#		infect()

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
	
		
func infect():
	if !infected:
		infected = true
		$DeathTimer.start()

func _on_Area2D_area_entered(area):
	collisions.append(area)

func _on_DeathTimer_timeout():
	health -= 5.0
	#var material = self.sprite.material as ShaderMaterial
	#material.set_shader_param("health", health)


func _on_Area2D_area_exited(area):
	collisions.erase(area)
