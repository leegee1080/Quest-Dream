extends Node2D

class_name Subtile_Deco

const subtile_deco_dict = {
	Tile_Enums.tile_themes_enum.castle: [12,8],
	Tile_Enums.tile_themes_enum.forest: [0,1,2,3,4,6,7,11,12],
	Tile_Enums.tile_themes_enum.grave: [2,5,4,6,8,12],
	Tile_Enums.tile_themes_enum.mountain: [2,3,6,12,10,8],
	Tile_Enums.tile_themes_enum.swamp: [4,6,7,12]
}

export(Tile_Enums.tile_themes_enum) var subtile_theme_enum = Tile_Enums.tile_themes_enum.castle
var icon_list

var ani_sprite


func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/deco_subtile_frames.tres"))
	generate_subtile()

func _init(new_theme):
	subtile_theme_enum = new_theme

func generate_subtile():
	icon_list = subtile_deco_dict.get(subtile_theme_enum)
	ani_sprite.set_frame(icon_list[int(rand_range(0, icon_list.size()))])
	add_child(ani_sprite)
