extends Node2D

class_name LootZ

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
	pass

func _ready():
	var temp_item_enum
	for num in range(0, loot_amt):
		randomize()
		#one roll for loot
		temp_item_enum =  GlobalVars.loot_tables[loot_filter][int(rand_range(0, GlobalVars.loot_tables[loot_filter].size()))]
		if temp_item_enum != null:
#			print(Item_Enums.item_subtypes.keys()[temp_item_enum])
			for rarity in Item_Enums.item_stat_rarity_weight:
					if Item_Enums.item_stat_rarity_weight[rarity] > loot_str:
#						item_list.append(Item.new(temp_item_enum, rarity))
						break
