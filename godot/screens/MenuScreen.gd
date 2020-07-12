extends Control

export(Resource) var target_scene

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit(0)
	if Input.is_action_just_pressed("submit"):
		Global.goto_scene(target_scene.resource_path)

func _on_FadeInTween_tween_completed(object, key):
	queue_free()
