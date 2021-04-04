extends Node2D

class_name Player

enum player_types_enum{
	soldier,
	valkyrie,
	ranger,
	executioner,
	berserker,
	knight,
	assassin,
	wizard,
	traveler,
	necromancer
}
const player_types_dict = {
	player_types_enum.soldier: Soldier,
	player_types_enum.valkyrie: Valkyrie,
	player_types_enum.ranger: Ranger,
	player_types_enum.executioner: Executioner,
	player_types_enum.berserker: Berserker,
	player_types_enum.knight: Knight,
	player_types_enum.assassin: Assassin,
	player_types_enum.wizard: Wizard,
	player_types_enum.traveler: Traveler,
	player_types_enum.necromancer: Necromancer
}

export(player_types_enum) var type_enum
var type_class
export(Dictionary) var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"equipment": {}
}
var level
var difficulty


var map_loc = Vector2(0,0)

var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	generate_player()
	return

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
		type_enum = player_types_enum.soldier
		return
	type_enum = new_type
	level = set_level
	difficulty = set_difficulty
	stat_dict["equipment"] = set_equipment
	

func generate_player():
	if type_enum == null:
		type_enum = player_types_enum.soldier
	type_class = player_types_dict.get(type_enum).new()
	print(type_class.name)
	stat_dict = type_class.stat_dict
	ani_sprite.set_frame(type_class.sprite_frame)

func process_turn():
	type_class.special()
	return

func take_hit():
	type_class.hit()
	return
