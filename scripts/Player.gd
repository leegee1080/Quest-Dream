extends Node2D


class_name Players

var rand_num = rand_range(0, len(Player_Type.player_types))
var type

func _init(new_type, level: int, difficulty: int, equipment: Dictionary):
	if new_type == null:
		self.type = Player_Type.player_types[Player_Type.player_types_enum.soldier]
		return
	self.type = Player_Type.player_types[new_type]


func process_turn():
	return
