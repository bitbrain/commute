extends Node

onready var timer = $Timer
onready var jukebox = $JukeBox

func _on_Timer_timeout():
	jukebox.play()
	timer.start(rand_range(12, 20))
