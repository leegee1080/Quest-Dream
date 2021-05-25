extends Node2D

class_name Loot

var loot_amt
var loot_str #used to gen the rarity
var loot_filter
var loot_table #changed based on the filter above
var item_list = []


func _init(new_loot_amount, new_filter): #loot filter must be Item_Enums.loot_filter_enum
	loot_amt = new_loot_amount
	loot_filter = new_filter
	loot_table = GlobalVars.loot_tables[new_filter]
	loot_str = GlobalVars.player_node_ref.player_stat_dict.speed + GlobalVars.player_node_ref.player_stat_dict.magic
	return

func _ready():
	#boss guaranteed loot, boosted loot_str value
	var temp_item_enum
	for num in range(loot_amt, 0,-1):
		randomize()
		#one roll for loot
		temp_item_enum =  GlobalVars.loot_tables[loot_filter][0][rand_range(0, GlobalVars.loot_tables[loot_filter].size())]
		if temp_item_enum == null:
			continue
		item_list.append(temp_item_enum)
		pass
	return
