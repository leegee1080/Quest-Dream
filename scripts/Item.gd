extends Node2D

class_name Item
#
#var item_name
#
#var item_spritesheet = "res://assets/visuals/item_frames.tres"
#
#func _init(new_subtype, new_rarity):
#	item_rarity = Item_Enums.item_stat_boost.get(new_rarity)
#	item_subtype = new_subtype
#	item_subclass = Item_Enums.item_types_dict.get(new_subtype)
#	item_name = str(Item_Enums.quality_types.keys()[new_rarity])  + " " +  str(Item_Enums.item_subtypes.keys()[new_subtype])
#
#func _ready():
#
#	return
#
#func use_item():  #use weapon- deal damage, use armor- reduce damage, use jewelry - apply stat bonus, use spell - cast spell, use consumable - apply effect
#	item_subclass.use(item_rarity)
