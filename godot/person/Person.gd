extends KinematicBody2D

const HEALTH_INFECTION_THRESHOLD = 80.0

export var health = 100.0
export var infected = false

onready var sprite = $Sprite

var collisions = []

func _ready():
	var material = sprite.material as ShaderMaterial
	material.set_shader_param("health", self.health)
	sprite.material = material.duplicate()
	if infected:
		$DeathTimer.start()
		
func _process(delta):
	for area in collisions:
		var other_player = area.get_parent()
		if other_player.infected && other_player.health <= HEALTH_INFECTION_THRESHOLD:
			infect()
		
func infect():
	if !infected:
		infected = true
		$DeathTimer.start()

func _on_Area2D_area_entered(area):
	collisions.append(area)

func _on_DeathTimer_timeout():
	health -= 5.0
	var material = self.sprite.material as ShaderMaterial
	material.set_shader_param("health", health)


func _on_Area2D_area_exited(area):
	collisions.erase(area)
