extends Node

class_name Action_BoostAttackPower

static func action():
	GlobalVars.player_type_class_storage.starting_attack_power += 1
	var particle = AttackUp.new(GlobalVars.player_node_ref.position)
	GlobalVars.main_node_ref.add_child(particle)
	return true
