extends Area2D


func _on_fallzone_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		get_tree().reload_current_scene()
