extends KinematicBody2D

var direction: float
var velocity = Vector2.ZERO
var speed: float = 125
var gravity: float = 1200
var jump_force: float = -315
var can_jump: bool = true

var hurted: bool

var knockback_direction = 1
var knockback_intencity = 175

var is_grounded: bool
onready var raycasts: Node2D = $Raycasts

var pressed_left: bool
var pressed_right: bool


func _ready():
	Global.hearts = 3
	position = Global.checkpoint_position
	
	AudioController.player_music()


func _physics_process(delta):
	if !is_grounded:
		velocity.y += gravity * delta
	else:
		can_jump = true
	
	if !hurted:
		if pressed_left:
			direction = -1
			velocity.x = lerp(velocity.x, speed * direction, 0.2)
			$AnimatedSprite.scale.x = direction
			
		elif pressed_right:
			direction = 1
			velocity.x = lerp(velocity.x, speed * direction, 0.2)
			$AnimatedSprite.scale.x = direction
		else:
			_get_input()

	velocity = move_and_slide(velocity, Vector2.UP)
	
	is_grounded = _check_is_grounded()
	
	_set_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)


func _get_input():
	direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.x = lerp(velocity.x, speed * direction, 0.2)
	print(direction)
	if direction != 0:
		$AnimatedSprite.scale.x = direction
		knockback_direction = direction


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded and can_jump:
		velocity.y = jump_force
		can_jump = false
		$jumpFx.play()
	if event.is_action_released("jump") and !is_grounded and can_jump:
		velocity.y = velocity.y / 2
		can_jump = false


func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false


func _on_hurtbox_body_entered(body):
	hurted = true
	Global.hearts -= 1
	knockback()
	get_node("hurtbox/CollisionShape2D").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.3), "timeout")
	get_node("hurtbox/CollisionShape2D").set_deferred("disabled", false)
	hurted = false
	$HitFX.play()
	
	if Global.hearts < 1:
		queue_free()
		get_tree().reload_current_scene()


func knockback():
	if $right.is_colliding():
		knockback_direction = -1
	if $left.is_colliding():
		knockback_direction = 1
	velocity.x = knockback_direction * knockback_intencity
	velocity = move_and_slide(velocity)


func hit_checkount():
	Global.checkpoint_position = Vector2(position.x + 13, position.y)


func _set_animation():
	var animation = "Idle"
	
	if !is_grounded:
		animation = "Jump"
		$AnimatedSprite/Particles2D.set_emitting(false)
	elif direction != 0:
		animation = "Run"
		$AnimatedSprite/Particles2D.set_emitting(true)
	else:
		animation = "Idle"
		
	if hurted:
		animation = "Hit"
		
	$AnimatedSprite.play(animation)


func _on_Left_pressed():
	pressed_left = true


func _on_Left_released():
	pressed_left = false


func _on_Right_pressed():
	pressed_right = true


func _on_Right_released():
	pressed_right = false


func _on_Jump_pressed():
	if is_grounded and can_jump:
		velocity.y = jump_force
		can_jump = false


func _on_Jump_released():
	velocity.y = velocity.y / 2
	can_jump = false
