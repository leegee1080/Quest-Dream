extends Node

class_name Action_Killself_getPaid

static func action():
	if GlobalVars.player_consumable_amount <= 2:
		return false
	var current_consume = GlobalVars.player_consumable_amount
	GlobalVars.money_gained_this_run = 0
	GlobalVars.change_money(current_consume - 2)
	GlobalVars.player_node_ref.take_hit(current_consume)
	return true
