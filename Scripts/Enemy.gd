extends KinematicBody2D

export var speed = 64
export var health = 1
export var timer: float = 2
var velocity = Vector2.ZERO
var direction = -1
var is_die: bool


func _ready():
	$Timer.wait_time = timer
	
	_set_animation("Run")


func _physics_process(delta):
	velocity.x = speed * direction

	if direction == 1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
		
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	if direction == 1:
		direction = -1
	else:
		direction = 1


func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.velocity.y = body.jump_force
		is_die = true
		$AnimatedSprite.play("Hit")


func _on_hitbox_body_exited(body):
	if is_die:
		queue_free()


func _set_animation(animation_name="Run"):
	$AnimatedSprite.play(animation_name)
