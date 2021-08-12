extends Node2D

class_name Money_Chest

var sound

var ani_sprite
var item_frame = 83
var open_chest = 84
var can_pick_up = true
var changes_direction = false

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	#play sound
	#play animation
	print("chest")
	if GlobalVars.keys_gained_this_run >= 1 or GlobalVars.player_node_ref.type_class.gimmick_class.bool_dict["chests_locked"] == false:
		#play opening sound
		#play opening animation
		if GlobalVars.player_node_ref.type_class.gimmick_class.bool_dict["chests_locked"] == true:
			GlobalVars.change_keys(-1)
#			GlobalVars.keys_gained_this_run -= 1
#		GlobalVars.money_gained_this_run += 10
		GlobalVars.change_money(10)
		GlobalVars.player_node_ref.ani_dict.happy.play_animation()
#		get_tree().call_group("UI_Player_Info", "update_keys")
#		get_tree().call_group("UI_Player_Info", "update_money")
		finish_pickup_animation()
		return changes_direction

func finish_pickup_animation():
	ani_sprite.set_frame(open_chest)
	can_pick_up = false
