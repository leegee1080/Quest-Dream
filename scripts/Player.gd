extends Node2D

class_name Player



var type

func _init(new_type, level: int, difficulty: int, equipment: Dictionary):
	if new_type == null:
		self.type = Player_Type.player_types_enum.soldier
		return
	self.type = new_type


func process_turn():
	return
