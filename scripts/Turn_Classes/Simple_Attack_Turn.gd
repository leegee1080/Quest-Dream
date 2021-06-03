extends Node

class_name Simple_Attack_Turn

func process_turn(new_target_list):
	randomize()
	var rand_index = int(rand_range(0, new_target_list.size()))
	get_parent().attack(new_target_list[rand_index])
	pass
