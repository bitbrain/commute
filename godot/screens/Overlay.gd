extends TextureRect

onready var tween = $FadeInTween

func _ready():
	visible = true
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 2.0, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()


func _on_FadeInTween_tween_completed(object, key):
	queue_free()
