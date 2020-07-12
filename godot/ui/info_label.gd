extends Label

const MIN_OPACITY = 0.15
const TIME = 1.0

onready var fade_in_tween = $FadeInTween
onready var fade_out_tween = $FadeOutTween

func _ready():
	modulate.a = MIN_OPACITY
	fade_in_tween.interpolate_property(self, "modulate:a", MIN_OPACITY, 1.0, TIME, Tween.TRANS_CUBIC, Tween.EASE_IN)
	fade_in_tween.start()


func _on_FadeInTween_tween_completed(object, key):
	fade_in_tween.stop_all()
	fade_out_tween.interpolate_property(self, "modulate:a", 1.0, MIN_OPACITY, TIME, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	fade_out_tween.start()


func _on_FadeOutTween_tween_completed(object, key):
	fade_out_tween.stop_all()
	fade_in_tween.interpolate_property(self, "modulate:a", MIN_OPACITY, 1.0, TIME, Tween.TRANS_CUBIC, Tween.EASE_IN)
	fade_in_tween.start()
