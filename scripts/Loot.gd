extends Node2D

class_name Loot

enum loot_filter_enum{
	boss,
	shop,
	normal
}
const loot_filter_to_table = {
	loot_filter_enum.boss: Item_Enums.boss_item_gen_chance_table,
	loot_filter_enum.shop: Item_Enums.shop_item_gen_chance_table,
	loot_filter_enum.normal: Item_Enums.enemy_item_gen_chance_table
}

var loot_amt
var loot_str #used to gen the rarity
var loot_filter
var loot_table #changed based on the filter above
var item_list = []


func _init(new_loot_amount, new_filter):
	loot_amt = new_loot_amount
	loot_filter = new_filter
	loot_table = loot_filter_to_table[new_filter]
	loot_str = GlobalVars.player_node_ref.player_stat_dict.speed + GlobalVars.player_node_ref.player_stat_dict.magic
	return

func _ready():
	#boss guaranteed loot, boosted loot_str value
	for num in range(loot_amt, 0,-1):
		randomize()
		#one roll for loot
		
		pass
	return
