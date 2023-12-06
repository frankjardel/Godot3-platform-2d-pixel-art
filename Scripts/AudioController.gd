extends Node

var music = AudioStreamPlayer.new()
var enemy_hit = AudioStreamPlayer.new()
var item_fx = AudioStreamPlayer.new()


#"res://Audio/Swinging Pants.ogg"
func player_music(file="res://Audio/Retro Beat.ogg"):
	if !music.is_playing():
		self.add_child(music)
		music.volume_db = -10
		music.stream = load(file)
		music.play()


func enemy_hit_fx(file="res://Audio/pepSound2.ogg"):
	if !enemy_hit.is_playing():
		self.add_child(enemy_hit)
		enemy_hit.stream = load(file)
		enemy_hit.play()


func collected_item_fx(file="res://Audio/confirmation_002.ogg"):
	if !item_fx.is_playing():
		self.add_child(item_fx)
		item_fx.volume_db = -25
		item_fx.stream = load(file)
		item_fx.play()
