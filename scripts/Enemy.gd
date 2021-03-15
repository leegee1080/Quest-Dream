extends Node2D

class_name Enemy


var type

func _init(new_type):
	generate_enemy_stats(new_type)

func generate_enemy_stats(new_type):
	if new_type == null:
		self.type = Enemy_Type.new(Enemy_Type.enemy_types_enum.alien_god)
		return
	self.type = Enemy_Type.new(new_type)

func process_turn():
	return
