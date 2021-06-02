extends Node2D

class_name Item_Enums

const all_item_types_dict = {
	"SwordS": Sword,
	"AxeS": Axe,
	"BowS": Bow
}

const normal_item_table = [
	all_item_types_dict.SwordS,
	all_item_types_dict.AxeS,
	all_item_types_dict.BowS
]

const treasure_item_table = [
	all_item_types_dict.SwordS,
	all_item_types_dict.AxeS,
	all_item_types_dict.BowS
]

const boss_item_table = [
	all_item_types_dict.SwordS,
	all_item_types_dict.AxeS,
	all_item_types_dict.BowS
]

enum loot_filter_enum{
	boss,
	treasure,
	normal
}

const loot_filter_dict = {
	loot_filter_enum.boss: boss_item_table,
	loot_filter_enum.treasure: treasure_item_table,
	loot_filter_enum.normal: normal_item_table
}
