extends Node2D

onready var platform = $KinematicBody2D
onready var tween = $Tween

export var speed = 3.0
export var horinzontal = true
export var distance = 192

var follow = Vector2.ZERO
const WAIT_DURATION = 1.0


func _ready():
	_start_tween()


func _start_tween():
	var direction = Vector2.RIGHT * distance if horinzontal else Vector2.UP * distance
	var duration = direction.length() / float(speed * 16)
	tween.interpolate_property(
		self,
		"follow",
		Vector2.ZERO,
		direction,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		WAIT_DURATION
	)
	tween.interpolate_property(
		self,
		"follow",
		direction,
		Vector2.ZERO,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		duration + WAIT_DURATION * 2
	)
	tween.start()


func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.05)
