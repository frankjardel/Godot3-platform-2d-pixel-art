extends ColorRect

var progress = 0.0


func _ready():
	pass # Replace with function body.


func _process(delta):
	material.set("shader_param/progress", progress)
