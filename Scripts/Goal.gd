extends Node2D

onready var changer = get_parent().get_node("Transition_in")
export var path: String = "res://Levels/Level02.tscn"


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Global.checkpoint_position = Vector2()
		$Particles2D.emitting = true
		changer.change_scene(path)
