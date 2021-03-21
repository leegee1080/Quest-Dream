extends Node2D

class_name Tile

const castle_type_dict = {
	Tile_Enums.tile_directions_enum.cross: 17,
	Tile_Enums.tile_directions_enum.elbow: 18,
	Tile_Enums.tile_directions_enum.straight: 19,
	Tile_Enums.tile_directions_enum.tee: 16,
	Tile_Enums.tile_directions_enum.impass: null
}
const forest_type_dict = {
	Tile_Enums.tile_directions_enum.cross: 13,
	Tile_Enums.tile_directions_enum.elbow: 14,
	Tile_Enums.tile_directions_enum.straight: 15,
	Tile_Enums.tile_directions_enum.tee: 12,
	Tile_Enums.tile_directions_enum.impass: null
	
}
const grave_type_dict = {
	Tile_Enums.tile_directions_enum.cross: 9,
	Tile_Enums.tile_directions_enum.elbow: 10,
	Tile_Enums.tile_directions_enum.straight: 11,
	Tile_Enums.tile_directions_enum.tee: 8,
	Tile_Enums.tile_directions_enum.impass: null
}
const mountain_type_dict = {
	Tile_Enums.tile_directions_enum.cross: 5,
	Tile_Enums.tile_directions_enum.elbow: 6,
	Tile_Enums.tile_directions_enum.straight: 7,
	Tile_Enums.tile_directions_enum.tee: 4,
	Tile_Enums.tile_directions_enum.impass: null
}
const swamp_type_dict = {
	Tile_Enums.tile_directions_enum.cross: 1,
	Tile_Enums.tile_directions_enum.elbow: 2,
	Tile_Enums.tile_directions_enum.straight: 3,
	Tile_Enums.tile_directions_enum.tee: 0,
	Tile_Enums.tile_directions_enum.impass: null
}
const tile_theme_dict = {
	Tile_Enums.tile_themes_enum.castle: castle_type_dict,
	Tile_Enums.tile_themes_enum.forest: forest_type_dict,
	Tile_Enums.tile_themes_enum.grave: grave_type_dict,
	Tile_Enums.tile_themes_enum.mountain: mountain_type_dict,
	Tile_Enums.tile_themes_enum.swamp: swamp_type_dict
}

export(Tile_Enums.tile_themes_enum) var theme_enum = Tile_Enums.tile_themes_enum.forest
export(Tile_Enums.tile_directions_enum) var direction_enum = Tile_Enums.tile_directions_enum.cross
export(Tile_Enums.center_type_enum) var center_object_enum = Tile_Enums.center_type_enum.none
var center_subtile
var current_tileset: Dictionary

var level
var difficulty


var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/tile_frames.tres"))
	generate_tile()

func _init(new_type, new_theme, new_center, set_level: int, set_difficulty: int):
	direction_enum = new_type
	theme_enum = new_theme
	center_object_enum = new_center
	level = set_level
	difficulty = set_difficulty

func generate_tile():
	ani_sprite.set_frame(tile_theme_dict.get(theme_enum).get(direction_enum))
	add_child(ani_sprite)
	place_center()
	print(Tile_Enums.tile_directions_enum.keys()[direction_enum])
	print(Tile_Enums.tile_themes_enum.keys()[theme_enum])
#	debug placement
	place_tile()

func place_center():
	if center_object_enum == Tile_Enums.center_type_enum.none:
		return
	center_subtile = Subtile_Center.new(theme_enum, center_object_enum)
	add_child(center_subtile)
	return

func place_deco():
	# Moves to Vector(0,0) at a speed of 1 unit per second
#	var speed = 1 # Change this to increase it to more units/second
#	position = position.move_toward(Vector2(0,0), delta * speed)
	return

func rotate_tile():
	return

func flip_tile():
	return

func pick_tile():
	return

func place_tile():
	place_deco()
	return
