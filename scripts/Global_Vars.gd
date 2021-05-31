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
var temp_loot_pool = [] #filled and cleared during each room event
const ani_dict = {#dictionary of all the animation classes
	"wiggle_in_place" : Walking_Animation,
	"melee_tackle" : Melee_Animation,
	"range" : null,
	"magic" : null,
	"hit_color_change" : Hit_Color_Animation,
	"death_flip_red" : Death_Animation
}
