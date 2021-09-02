extends Node2D

class_name Enemy_Enums

enum enemy_types_enum{
	goblin,
	spider
}
const enemy_types_dict = {
	enemy_types_enum.goblin: Goblin,
	enemy_types_enum.spider: Minion_Spider
}
