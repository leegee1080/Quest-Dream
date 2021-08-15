extends Node2D

class_name Safe_Switch
#this centertile will flip all elbows and tees
var sound

var ani_sprite
var item_frame = 87
const can_pick_up = true
var changes_direction = false

const rot_num_flip_dict = {
	0: 1,
	1: 0,
	2: 3,
	3: 2
}

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	print("tile switch")
	var ingame_tile_child_array = GlobalVars.main_node_ref.ingame_tilegroup_Node.get_children()
	for tile in ingame_tile_child_array:
		if tile == null or tile.direction_enum == null:
			continue
		if tile.is_in_play and (tile.direction_enum == 1 or tile.direction_enum == 3):
			var old_tile_rot_var = tile.rotate_var
			tile.rotate_var = rot_num_flip_dict.get(old_tile_rot_var)
			tile.ani_sprite.set_frame(tile.tile_theme_dict.get(tile.theme_enum).get(tile.direction_enum)[tile.rotate_var])
	if GlobalVars.player_type_class_storage.gimmick_class.bool_dict["pickup_switch"] == true:
		finish_pickup_animation()	
	return changes_direction
	#play sound

func finish_pickup_animation():
	get_parent().center_object_enum = 0
	queue_free()
	pass
