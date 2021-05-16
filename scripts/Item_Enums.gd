extends Node2D

class_name Item_Enums

enum item_types{
	armor,
	weapon,
	jewelry,
	spell,
	consumable
}

enum item_subtypes{
	sword,
	axe,
	bow,
	shield,
	chest,
	helmet,
	ring,
	amulet,
	potion,
	food,
	money,
	spell_damage_single,
	spell_damage_many,
	spell_healing,
	spell_stun
}

const enemy_types_dict = {
	item_subtypes.sword: Avatar,
	item_subtypes.axe: Goblin,
	item_subtypes.bow: Goblin_Wizard,
	item_subtypes.shield: Monkey,
	item_subtypes.chest: Robber,
	item_subtypes.helmet: Human_Wizard,
	item_subtypes.ring: Human_Sorcerer,
	item_subtypes.amulet: Human_Jack,
	item_subtypes.potion: Human_Queen,
	item_subtypes.food: Human_King,
	item_subtypes.money: Rat,
	item_subtypes.spell_damage_single: Bat,
	item_subtypes.spell_damage_many: Dog,
	item_subtypes.spell_healing: Snake,
	item_subtypes.spell_stun: Spider_Tiny
}

const item_subtype_cat = {
	item_types.armor: [item_subtypes.chest, item_subtypes.helmet],
	item_types.weapon: [item_subtypes.sword, item_subtypes.axe, item_subtypes.bow, item_subtypes.shield],
	item_types.jewelry: [item_subtypes.ring, item_subtypes.amulet],
	item_types.spell: [item_subtypes.spell_damage_single, item_subtypes.spell_damage_many, item_subtypes.spell_healing, item_subtypes.spell_stun],
	item_types.consumable: [item_subtypes.potion, item_subtypes.food, item_subtypes.money]
}

enum quality_types{
	trash,
	common,
	uncommon,
	rare,
	unique,
	masterwork,
	legendary
}

const item_stat_boost = {
	quality_types.trash: 1,
	quality_types.common: 2,
	quality_types.uncommon: 3,
	quality_types.rare: 4,
	quality_types.unique: 5,
	quality_types.masterwork: 6,
	quality_types.legendary: 7
}


