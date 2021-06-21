extends Node

class_name Roll_Dodge_1

var animation_class = null
var sprite_frame = 50

var ani_sprite

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite
	pass

func dodge(direction):
	if get_parent().lane_index == 0 and direction == "up" or get_parent().lane_index == 4 and direction == "down":
		#bump the wall
		get_parent().current_battle_state = Battle_Enums.battle_states.ready
		return
	if direction == "down":
		get_parent().lane_index += 1
		print("dodge " + direction)
		get_parent().current_battle_state = Battle_Enums.battle_states.ready
		return
	if direction == "up":
		get_parent().lane_index -= 1
		print("dodge " + direction)
		get_parent().current_battle_state = Battle_Enums.battle_states.ready
		return
