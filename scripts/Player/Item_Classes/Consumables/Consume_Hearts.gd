extends Node2D

class_name Consume_Hearts

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
	print("consumable")
	get_tree().call_group("UI_Player_Info", "update_consumable")
	GlobalVars.player_node_ref.consumable_amt += 1
	finish_pickup_animation()

func finish_pickup_animation():
	queue_free()
