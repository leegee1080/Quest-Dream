extends Node2D

class_name Money_Chest

var sound

var ani_sprite
var item_frame = 83
var open_chest = 84
var pick_up = true

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	#play sound
	#play animation
	print("chest")
	GlobalVars.keys_gained_this_run -= 1
	GlobalVars.money_gained_this_run += 10
	get_tree().call_group("UI_Player_Info", "update_keys")
	get_tree().call_group("UI_Player_Info", "update_money")
	finish_pickup_animation()

func finish_pickup_animation():
	ani_sprite.set_frame(open_chest)
	pick_up = false
