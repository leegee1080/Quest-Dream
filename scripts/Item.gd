extends Node2D

class_name Item

var item_type #this is the enum of the item (ex. weapon, armor...)
var item_rarity #this is the int of the stat boost, applied from the rarity enum (ex. 0, 1, ....)
var item_subtype #this is the enum of the subtype (ex. sword, chest, helmet, food....)
var item_subclass #this is the class of the instanced item based on the above enums

func _init(new_type, new_rarity, new_subtype):
	item_type = new_subtype
	item_rarity = Item_Enums.item_stat_boost.get(new_rarity)
	item_subtype = new_subtype
	return

func _ready():
	return

func use_item():  #use weapon- deal damage, use armor- reduce damage, use jewelry - apply stat bonus, use spell - cast spell, use consumable - apply effect
	item_subclass.use(item_rarity)
