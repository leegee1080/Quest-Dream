extends Node2D

class_name Player

var generic_player_stats = Player_Type.new()
var type_enum
var type_stats
var level
var difficulty
var equipment
var my_sprite = Sprite.new()

func _ready():
	generate_player()
	return

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
		self.type_enum = generic_player_stats.player_types_enum.soldier
		return
	self.type_enum = new_type
	self.level = set_level
	self.difficulty = set_difficulty
	self.equipment = set_equipment
	

func generate_player():
	if self.type_enum == null:
		self.type_enum = generic_player_stats.player_types_enum.soldier
	self.type_stats = generic_player_stats.player_types.get(self.type_enum)
	add_child(my_sprite)
	print(self.type_stats.get("name"))
	my_sprite.texture = load(self.type_stats.get("icon"))

func process_turn():
	return
