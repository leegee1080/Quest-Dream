extends Node2D

class_name Room

#this for the sprite frame
const room_theme_dict = {
	Tile_Enums.tile_themes_enum.castle: 0,
	Tile_Enums.tile_themes_enum.forest: 1,
	Tile_Enums.tile_themes_enum.grave: 2,
	Tile_Enums.tile_themes_enum.mountain: 3,
	Tile_Enums.tile_themes_enum.swamp: 4
}

#[0base enemies to gen, 1base loot to gen, 2base number of shopkeep items, 3can return to room true1/false0, 4can rest true1/false0]
const room_type_dict = {
	Tile_Enums.center_type_enum.battle: [1, 1, 0, 0, 0],
	Tile_Enums.center_type_enum.treasure: [0, 1, 0, 1, 0],
	Tile_Enums.center_type_enum.shop: [0, 0, 1, 1, 0],
	Tile_Enums.center_type_enum.rest: [0, 0, 0, 0, 1],
	Tile_Enums.center_type_enum.silly: [0, 0, 0, 0, 0]
}



var type_enum
var room_type_hash #stores the stats about the room type from the room_type_dict
var theme_enum
var room_theme_frame #stores the frame number of the room theme
var room_screen_loc #the location the room will appear on the player's screen

var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(room_theme_frame)
	position = room_screen_loc
	generate_room()
	return

func _init(new_type, new_theme, level, new_room_screen_loc):
	if new_theme in room_theme_dict:
		theme_enum = new_theme
	else:
		theme_enum = Tile_Enums.tile_themes_enum.castle
	if new_type in room_type_dict:
		type_enum = new_type
	else:
		type_enum = Tile_Enums.center_type_enum.silly
	room_type_hash = room_type_dict[type_enum]
	room_theme_frame = room_theme_dict[theme_enum]
	room_screen_loc = new_room_screen_loc
	return

func generate_room():
	#create anisprite
	add_child(ani_sprite)
	return

func leave_room():
	if room_type_hash[3] == 0:
		get_parent().delete_centertile()
		queue_free()
		return
	#do not delete room, this needs to save it but hide/regen child parts
	get_parent().save_centertile()
	queue_free()
	return
