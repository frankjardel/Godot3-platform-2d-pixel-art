extends Area2D

var effect = preload("res://Scenes/Collected.tscn")
export var fruits = 1

func _on_Apple_body_entered(body):
	if body.name == "Player":
		AudioController.collected_item_fx()
		
		var instance = effect.instance()
		instance.global_transform = self.global_transform
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(instance)
		
		Global.fruits += fruits
		
		queue_free()
