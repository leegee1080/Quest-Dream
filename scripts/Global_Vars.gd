extends Node

var main_node_ref
var player_node_ref
var stage_enemies_dict = { #this dict is filled at start of the main class, there is a list of all possible enemies per level of this theme
	0 : [],#this is the index of the boss enemies
	1 : [],
	2 : [],
	3 : [],
	4 : []
}
var loot_tables = {#this is the dict of the loot tables organized by loot filter(boss, shop, normal)
	Item_Enums.loot_filter_enum.boss: [],
	Item_Enums.loot_filter_enum.shop: [],
	Item_Enums.loot_filter_enum.normal: []
}
