extends Node

class_name Gimmick_Exec

const bool_dict = {
	"pickup_keys": true,
	"pickup_money": true,
	"kill_money": true,
	"boss_money": true,
	"pickup_consumable": true,
	"doors_locked": true,
	"chests_locked": true,
	"pickup_reverse": false,
	"pickup_switch": false,
	"turn_around_damage": 1,
	"outer_wall_damage": 1
}

static func activate_gimmick():
	var kills = GlobalVars.player_type_class_storage.kills
	GlobalVars.money_gained_total += kills
	pass
