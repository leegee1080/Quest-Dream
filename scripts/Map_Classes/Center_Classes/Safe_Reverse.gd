extends Node2D

class_name Safe_Reverse

var sound

var ani_sprite
var item_frame = 81
const can_pick_up = true

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	GlobalVars.player_node_ref.direction = (GlobalVars.player_node_ref.direction *-1)
	#play sound

func finish_pickup_animation():
	queue_free()
