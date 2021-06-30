extends Node

class_name Attack_Then_Move_Random_Turn

func process_turn(new_target_list):
	randomize()
	var rand_index = int(rand_range(0, new_target_list.size()))
	get_parent().attack(new_target_list[rand_index])
	pass
