extends Node2D

class_name Tile

enum tile_themes_enum{
	castle,
	forest,
	grave,
	mountain,
	swamp
}
enum tile_types_enum{
	cross,
	elbow,
	straight,
	tee
}


export(tile_types_enum) var type_enum
var type_class

var level
var difficulty
var direction
var center_object

var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	generate_tile()
	return

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
#		type_enum = player_types_enum.soldier
		return
	type_enum = new_type
	level = set_level
	difficulty = set_difficulty
	

func generate_tile():
	if type_enum == null:
		type_enum = player_types_enum.soldier
	print(type_class.name)
	ani_sprite.set_frame(type_class.sprite_frame)

func enter_center():
	return

func rotate_tile():
	return

func flip_tile():
	return
