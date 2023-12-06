extends CanvasLayer

onready var score: Label = $HBoxContainer/Holder3/score
onready var health: Label = $HBoxContainer/Holder/score


func _ready():
	Global.fruits = 0


func _process(delta):
	score.text = str(Global.fruits)
	health.text = str(Global.hearts)
