extends Node2D

class_name Comsume_Hearts

var sound

var ani_sprite
var item_frame = 77

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	#play sound
	#play animation
	print("money")
	GlobalVars.money_gained_this_run += 1
	finish_pickup_animation()

func finish_pickup_animation():
	queue_free()