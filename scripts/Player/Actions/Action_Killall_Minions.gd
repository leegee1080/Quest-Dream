extends Node

class_name Action_Killall_Minions

static func action():
	GlobalVars.call_func_all_minions("instant_kill")
	return true
