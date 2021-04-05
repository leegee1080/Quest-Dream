extends Node2D

class_name Tile

const castle_type_dict = {
	Tile_Enums.tile_directions_enum.cross: [36],
	Tile_Enums.tile_directions_enum.elbow: [39,40,41,42],
	Tile_Enums.tile_directions_enum.straight: [37,38],
	Tile_Enums.tile_directions_enum.tee: [45,46,47,48],
	Tile_Enums.tile_directions_enum.impass: [43],
	Tile_Enums.tile_directions_enum.boss: [44],
	Tile_Enums.tile_directions_enum.terminal: [49,50,51,52]
}
const forest_type_dict = {
	Tile_Enums.tile_directions_enum.cross: [18],
	Tile_Enums.tile_directions_enum.elbow: [21,22,23,24],
	Tile_Enums.tile_directions_enum.straight: [19,20],
	Tile_Enums.tile_directions_enum.tee: [27,28,29,30],
	Tile_Enums.tile_directions_enum.impass: [25],
	Tile_Enums.tile_directions_enum.boss: [26],
	Tile_Enums.tile_directions_enum.terminal: [31,32,33,34]
}
const grave_type_dict = {
	Tile_Enums.tile_directions_enum.cross: [54],
	Tile_Enums.tile_directions_enum.elbow: [57,58,59,60],
	Tile_Enums.tile_directions_enum.straight: [55,56],
	Tile_Enums.tile_directions_enum.tee: [63,64,65,66],
	Tile_Enums.tile_directions_enum.impass: [61],
	Tile_Enums.tile_directions_enum.boss: [62],
	Tile_Enums.tile_directions_enum.terminal: [67,68,69,70]
}
const mountain_type_dict = {
	Tile_Enums.tile_directions_enum.cross: [0],
	Tile_Enums.tile_directions_enum.elbow: [3,4,5,6],
	Tile_Enums.tile_directions_enum.straight: [1,2],
	Tile_Enums.tile_directions_enum.tee: [9,10,11,12],
	Tile_Enums.tile_directions_enum.impass: [7],
	Tile_Enums.tile_directions_enum.boss: [8],
	Tile_Enums.tile_directions_enum.terminal: [13,14,15,16]
}
const swamp_type_dict = {
	Tile_Enums.tile_directions_enum.cross: [72],
	Tile_Enums.tile_directions_enum.elbow: [75,76,77,78],
	Tile_Enums.tile_directions_enum.straight: [73,74],
	Tile_Enums.tile_directions_enum.tee: [81,82,83,84],
	Tile_Enums.tile_directions_enum.impass: [79],
	Tile_Enums.tile_directions_enum.boss: [80],
	Tile_Enums.tile_directions_enum.terminal: [85,86,87,88]
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

var is_locked = false

var deco_number
var deco_list = []

var player_level
var difficulty
var center_level

var rotate_var = 0

var init_chosen_sprite
var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/tile_frames.tres"))
	generate_tile()


func _init(new_type, new_theme, new_center, set_level: int, set_difficulty: int, new_deco_number: int, new_center_level: int, chosen_sprite: int): #if chosen_sprite is -1 then rand gen sprite
	direction_enum = new_type
	theme_enum = new_theme
	center_object_enum = new_center
	player_level = set_level
	difficulty = set_difficulty
	deco_number = new_deco_number
	center_level = new_center_level
	init_chosen_sprite = chosen_sprite

func generate_tile():
	if init_chosen_sprite == -1:
		randomize()
		rotate_var = int(rand_range(0,tile_theme_dict.get(theme_enum).get(direction_enum).size()))
		ani_sprite.set_frame(tile_theme_dict.get(theme_enum).get(direction_enum)[rotate_var])
		add_child(ani_sprite)
		place_center()
		return
	ani_sprite.set_frame(tile_theme_dict.get(theme_enum).get(direction_enum)[init_chosen_sprite])
	add_child(ani_sprite)
	place_center()
	return

func place_center():
	if center_object_enum == Tile_Enums.center_type_enum.none:
		return
	center_subtile = Subtile_Center.new(theme_enum, center_object_enum, center_level)
	add_child(center_subtile)
	return

func place_deco():
	var multi = [1,1,1,-1,-1,-1]
	randomize()
	while deco_number > 0:
		var temp_deco = Subtile_Deco.new(theme_enum)
		deco_list.append(temp_deco)
		deco_number -= 1
	for deco in deco_list:
		multi.shuffle()
		var rngx = rand_range(14.0, 18.0)* multi[0]
		multi.shuffle()
		var rngy = rand_range(14.0, 18.0)* multi[0]
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
	if is_locked == false:
		queue_free()


func lock_tile():
	return

func place_tile(new_loc: Vector2, is_preplaced: bool):
	#place tile in clicked location
	self.position.x = new_loc.x
	self.position.y = new_loc.y
	place_deco()
	if is_preplaced == true:
		is_locked = true
	return