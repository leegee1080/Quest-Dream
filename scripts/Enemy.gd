extends Node2D

class_name Enemy


var generic_enemy_types = Enemy_Type.new()
var type_enum
var type_stats
var my_sprite = Sprite.new()

func _ready():
	generate_enemy_stats()

func _init(new_type):
	self.type_enum = new_type

func generate_enemy_stats():
	if self.type_enum == null:
		self.type_enum = generic_enemy_types.enemy_types_enum.rat
	self.type_stats = generic_enemy_types.enemy_types_dict.get(self.type_enum)
	add_child(my_sprite)
	print(self.type_stats.get("name"))
	my_sprite.texture = load(self.type_stats.get("icon"))

func process_turn():
	return
