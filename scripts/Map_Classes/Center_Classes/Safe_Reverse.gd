extends Node2D

class_name Safe_Reverse

var sound

var ani_sprite
var item_frame = 93
const can_pick_up = true
var changes_direction = true

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	GlobalVars.player_node_ref.direction = (GlobalVars.player_node_ref.direction *-1)
	if GlobalVars.player_type_class_storage.gimmick_class.bool_dict["pickup_reverse"] == true:
		finish_pickup_animation()
	return changes_direction
	#play sound

func finish_pickup_animation():
	get_parent().center_object_enum = 0
	queue_free()
