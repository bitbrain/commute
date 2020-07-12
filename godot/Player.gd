extends YSort

export(float) var max_health = 100.0
export(float) var base_damage = 5.0

signal on_health_percentage_changed(health_percentage)
signal on_player_infected()

onready var person = $Person

var input_vector = Vector2.ZERO
var close_persons = []
var health = 0 setget set_health
var original_position = Vector2.ZERO

func _ready():
	self.original_position = person.position
	self.health = max_health
	
func reset():
	self.health = max_health
	self.person.position = original_position

func _process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	person.input_vector = input_vector

func reduce_health(points):
	self.health = max(0, self.health - points)

func set_health(h):
	var old_health = health
	health = h
	if old_health != h:
		emit_signal("on_health_percentage_changed", health / max_health)
	if old_health > 0.0 && health <= 0:
		emit_signal("on_player_infected")

func _on_Area2D_area_entered(area):
	close_persons.append(area.get_parent())

func _on_Area2D_area_exited(area):
	close_persons.erase(area.get_parent())

func _on_InfectionTimer_timeout():
	for close_person in close_persons:
		if close_person.is_infected() && !close_person.has_mask():
			var distance = person.global_position.distance_to(close_person.global_position)
			reduce_health(600.0 / distance)
