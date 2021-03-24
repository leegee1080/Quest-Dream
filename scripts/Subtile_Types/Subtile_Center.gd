extends Node2D

class_name Subtile_Center


const subtile_castle_type_dict = {
	Tile_Enums.center_type_enum.battle: [0, 1, 2, 3],
	Tile_Enums.center_type_enum.treasure: [9, 10, 12],
	Tile_Enums.center_type_enum.shop: [6, 7, 8],
	Tile_Enums.center_type_enum.rest: [11, 13],
	Tile_Enums.center_type_enum.silly: [4, 5]
}
const subtile_forest_type_dict = {
	Tile_Enums.center_type_enum.battle: [0, 1, 2, 3],
	Tile_Enums.center_type_enum.treasure: [9, 10, 12],
	Tile_Enums.center_type_enum.shop: [6, 7, 8],
	Tile_Enums.center_type_enum.rest: [11, 13],
	Tile_Enums.center_type_enum.silly: [4, 5]
}
const subtile_grave_type_dict = {
	Tile_Enums.center_type_enum.battle: [0, 1, 2, 3],
	Tile_Enums.center_type_enum.treasure: [9, 10, 12],
	Tile_Enums.center_type_enum.shop: [6, 7, 8],
	Tile_Enums.center_type_enum.rest: [11, 13],
	Tile_Enums.center_type_enum.silly: [4, 5]
}
const subtile_mountain_type_dict = {
	Tile_Enums.center_type_enum.battle: [0, 1, 2, 3],
	Tile_Enums.center_type_enum.treasure: [9, 10, 12],
	Tile_Enums.center_type_enum.shop: [6, 7, 8],
	Tile_Enums.center_type_enum.rest: [11, 13],
	Tile_Enums.center_type_enum.silly: [4, 5]
}
const subtile_swamp_type_dict = {
	Tile_Enums.center_type_enum.battle: [0, 1, 2, 3],
	Tile_Enums.center_type_enum.treasure: [9, 10, 12],
	Tile_Enums.center_type_enum.shop: [6, 7, 8],
	Tile_Enums.center_type_enum.rest: [11, 13],
	Tile_Enums.center_type_enum.silly: [4, 5]
}
const subtile_theme_dict = {
	Tile_Enums.tile_themes_enum.castle: subtile_castle_type_dict,
	Tile_Enums.tile_themes_enum.forest: subtile_forest_type_dict,
	Tile_Enums.tile_themes_enum.grave: subtile_grave_type_dict,
	Tile_Enums.tile_themes_enum.mountain: subtile_mountain_type_dict,
	Tile_Enums.tile_themes_enum.swamp: subtile_swamp_type_dict
}


export(Tile_Enums.tile_themes_enum) var subtile_theme_enum = Tile_Enums.tile_themes_enum.forest
export(Tile_Enums.center_type_enum) var subtile_type_enum = Tile_Enums.center_type_enum.none
export(Array) var icon_list
export(int) var subtile_level

var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/center_subtile_frames.tres"))
	generate_subtile()

func _init(new_theme, new_type, new_level):
	subtile_theme_enum = new_theme
	subtile_type_enum = new_type
	subtile_level = new_level

func generate_subtile():
	if subtile_type_enum == Tile_Enums.center_type_enum.none:
		return
	icon_list = subtile_theme_dict.get(subtile_theme_enum).get(subtile_type_enum)
	#pick the frame from the list
	if subtile_level > icon_list.size():
		ani_sprite.set_frame(icon_list[0])
		subtile_level = 0
	else:
		ani_sprite.set_frame(icon_list[subtile_level])
	add_child(ani_sprite)
	print(Tile_Enums.center_type_enum.keys()[subtile_type_enum])

func change_subtile(new_type):
	subtile_type_enum = new_type
	return

func move_subtile(new_type):
	subtile_type_enum = new_type
	return
