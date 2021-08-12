extends Node

const stage_order = { #the stage number and corresponding theme 
	1: Tile_Enums.tile_themes_enum.forest,
	6: Tile_Enums.tile_themes_enum.mountain,
	11: Tile_Enums.tile_themes_enum.swamp,
	16: Tile_Enums.tile_themes_enum.grave,
	21: Tile_Enums.tile_themes_enum.castle
}

var current_stage_number: int = 1
const difficulty_increment = 0.5
var current_theme = Tile_Enums.tile_themes_enum.castle

var money_gained_total = 200
var money_gained_this_run = 0
#var money_gained_this_boss = 0

var keys_gained_this_run = 0

var player_type_class_storage
var main_node_ref
var player_node_ref
var player_consumable_amount = 0

var stage_enemies_dict = { #this dict is filled at start of the main class, there is an array for each them of sub_boss[0] and bosses[1]
	Tile_Enums.tile_themes_enum.forest : [[],[]],
	Tile_Enums.tile_themes_enum.mountain : [[],[]],
	Tile_Enums.tile_themes_enum.swamp : [[],[]],
	Tile_Enums.tile_themes_enum.grave : [[],[]],
	Tile_Enums.tile_themes_enum.castle : [[],[]]
}

var tile_path_type_chance_array = []
var tile_center_chance_array = []
var premade_center_chance_array = []

func change_money(amount):
	money_gained_this_run += amount
	get_tree().call_group("UI_Player_Info", "update_money")
	pass

func change_consume(amount):
	player_consumable_amount += amount
	get_tree().call_group("UI_Player_Info", "update_consumable")
	pass

func change_keys(amount):
	keys_gained_this_run += amount
	get_tree().call_group("UI_Player_Info", "update_keys")
	pass
