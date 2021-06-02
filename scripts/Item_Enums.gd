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
	food, #increase player level and small health
#	money,
	spell_damage_single,
	spell_damage_many,
	spell_healing,
	spell_stun
}

const item_types_dict = {
	item_subtypes.sword: Sword,
	item_subtypes.axe: Axe,
	item_subtypes.bow: Bow,
	item_subtypes.shield: Shield,
	item_subtypes.chest: Chest,
	item_subtypes.helmet: Helmet,
	item_subtypes.ring: Ring,
	item_subtypes.amulet: Amulet,
	item_subtypes.potion: Potion,
	item_subtypes.food: Food,
#	item_subtypes.money: Money,
	item_subtypes.spell_damage_single: Bolt_Spell,
	item_subtypes.spell_damage_many: Fireball_Spell,
	item_subtypes.spell_healing: Heal_Spell,
	item_subtypes.spell_stun: Stun_Spell
}

const item_subtype_cat = {
	item_types.armor: [item_subtypes.chest, item_subtypes.helmet],
	item_types.weapon: [item_subtypes.sword, item_subtypes.axe, item_subtypes.bow, item_subtypes.shield],
	item_types.jewelry: [item_subtypes.ring, item_subtypes.amulet],
	item_types.spell: [item_subtypes.spell_damage_single, item_subtypes.spell_damage_many, item_subtypes.spell_healing, item_subtypes.spell_stun],
	item_types.consumable: [item_subtypes.potion, item_subtypes.food]
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

const item_stat_rarity_weight = { 
	quality_types.trash: 47,
	quality_types.common: 94,
	quality_types.uncommon: 141,
	quality_types.rare: 188,
	quality_types.unique: 235,
	quality_types.masterwork: 282,
	quality_types.legendary: 329
}
#these numbers are created by looking at the maximum a player could get after one level then multiplying it by the number of levels and then dividing it by the number tiers of rarity (3 rounds in a level) (level is a whole theme)

const normal_item_gen_chance_table = {
	0: [1000, null],
	1: [1, item_subtypes.sword],
	2: [1, item_subtypes.axe],
	3: [1, item_subtypes.bow],
	4: [1, item_subtypes.shield],
	5: [1, item_subtypes.chest],
	6: [1, item_subtypes.helmet],
	7: [1, item_subtypes.ring],
	8: [1, item_subtypes.amulet],
	9: [10, item_subtypes.potion],
	10: [30, item_subtypes.food],
	11: [1, item_subtypes.spell_damage_single],
	12: [1, item_subtypes.spell_damage_many],
	13: [1, item_subtypes.spell_healing],
	14: [1, item_subtypes.spell_stun]
}

const shop_item_gen_chance_table = {
	0: [0, null],
	1: [1, item_subtypes.sword],
	2: [1, item_subtypes.axe],
	3: [1, item_subtypes.bow],
	4: [1, item_subtypes.shield],
	5: [1, item_subtypes.chest],
	6: [1, item_subtypes.helmet],
	7: [1, item_subtypes.ring],
	8: [1, item_subtypes.amulet],
	9: [10, item_subtypes.potion],
	10: [10, item_subtypes.food],
	11: [1, item_subtypes.spell_damage_single],
	12: [1, item_subtypes.spell_damage_many],
	13: [1, item_subtypes.spell_healing],
	14: [1, item_subtypes.spell_stun]
}

const boss_item_gen_chance_table = {
	0: [0, null],
	1: [1, item_subtypes.sword],
	2: [1, item_subtypes.axe],
	3: [1, item_subtypes.bow],
	4: [1, item_subtypes.shield],
	5: [1, item_subtypes.chest],
	6: [1, item_subtypes.helmet],
	7: [1, item_subtypes.ring],
	8: [1, item_subtypes.amulet],
	9: [0, item_subtypes.potion],
	10: [0, item_subtypes.food],
	11: [1, item_subtypes.spell_damage_single],
	12: [1, item_subtypes.spell_damage_many],
	13: [1, item_subtypes.spell_healing],
	14: [1, item_subtypes.spell_stun]
}

enum loot_filter_enum{
	boss,
	shop,
	normal
}
