extends Node2D

class_name Safe_Keygate

var sound

var ani_sprite
var item_frame = 88
var gate_open_frame = 89
var can_pick_up = true
var changes_direction = true

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	print("gate")
	if GlobalVars.player_node_ref.type_class.gimmick_class.bool_dict["doors_locked"] == true:
		if GlobalVars.keys_gained_this_run <= 0:
			GlobalVars.player_node_ref.direction = (GlobalVars.player_node_ref.direction *-1)
			return changes_direction
		GlobalVars.keys_gained_this_run -= 1
	get_tree().call_group("UI_Player_Info", "update_keys")
	finish_pickup_animation()
	#play sound
	return changes_direction

func finish_pickup_animation():
	ani_sprite.set_frame(gate_open_frame)
	get_parent().center_object_enum = 0
	can_pick_up = false
	changes_direction = false
