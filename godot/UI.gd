extends CanvasLayer

func _ready():
	$AmbientLight.visible = true

func _on_Player_on_health_percentage_changed(health_percentage):
	$HealthBar.set_health_percentage(health_percentage)
