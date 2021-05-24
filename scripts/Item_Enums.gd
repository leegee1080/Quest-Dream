extends Node2D

class_name Item_Enums

const enemy_item_gen_chance_table = [
	"none",
	"none",
	"none",
	"none",
	"money",
	"money",
	"money",
	"item"
]
const shop_item_gen_chance_table = [
	"sword",
	"axe",
	"bow",
	"shield",
	"chest",
	"helmet",
	"ring",
	"amulet",
	"potion",
	"food", #increase player level and small health
	"spell_damage_single",
	"spell_damage_many",
	"spell_healing",
	"spell_stun"
]
const boss_item_gen_chance_table = [
	"sword",
	"axe",
	"bow",
	"shield",
	"chest",
	"helmet",
	"ring",
	"amulet",
	"spell_damage_single",
	"spell_damage_many",
	"spell_healing",
	"spell_stun"
]

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
	money,
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
	item_subtypes.money: Money,
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


