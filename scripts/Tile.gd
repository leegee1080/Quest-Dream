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

#pull info about the centertile here
var center_subtile
var current_tileset: Dictionary

var is_placed = false

var deco_number
var deco_list = []

var player_level
var difficulty
var center_level

const rot = [0,90,180,-90]
var rotate_var = 0

var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/tile_frames.tres"))
	generate_tile()

func _init(new_type, new_theme, new_center, set_level: int, set_difficulty: int, new_deco_number: int, new_center_level: int):
	direction_enum = new_type
	theme_enum = new_theme
	center_object_enum = new_center
	player_level = set_level
	difficulty = set_difficulty
	deco_number = new_deco_number
	center_level = new_center_level

func generate_tile():
	ani_sprite.set_frame(tile_theme_dict.get(theme_enum).get(direction_enum))
	add_child(ani_sprite)
	randomize()
	rotate_var = rot[int(rand_range(0,3))]
	ani_sprite.rotation_degrees = rotate_var
	place_center()

func place_center():
	if center_object_enum == Tile_Enums.center_type_enum.none:
		return
	center_subtile = Subtile_Center.new(theme_enum, center_object_enum, center_level)
	add_child(center_subtile)
	return

func place_deco():
	var multi = [1,1,1,-1,-1,-1,0]
	randomize()
	while deco_number > 0:
		var temp_deco = Subtile_Deco.new(theme_enum)
		deco_list.append(temp_deco)
		deco_number -= 1
	for deco in deco_list:
		multi.shuffle()
		var rngx = rand_range(12.0, 18.0)* multi[0]
		multi.shuffle()
		var rngy = rand_range(12.0, 18.0)* multi[0]
		add_child(deco)
		deco.translate(Vector2(rngx,rngy))
	return

#i think i am going to remove this and just allow the player to delete the tile until the character walks over the tile
#func rotate_tile():
#	return
#
#func flip_tile():
#	return
#
#func pick_tile():
#	return
func delete_tile():
	return

func lock_tile():
	return

func place_tile(new_loc: Vector2):
	#place tile in clicked location
	self.position.x = new_loc.x
	self.position.y = new_loc.y
	place_deco()
	return
