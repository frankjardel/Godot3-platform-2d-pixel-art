extends Area2D


func _on_Checkount_body_entered(body):
	if body.name == "Player":
		body.hit_checkount()
		$AnimatedSprite.play("Idle")
		$CollisionShape2D.queue_free()
