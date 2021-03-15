class_name Player_Type

enum player_types_enum{
	soldier,
	valkyrie,
	ranger,
	executioner,
	berserker,
	knight,
	assassin,
	wizard,
	traveler,
	necromancer
}

const soldier = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile190.png"
}
const valkyrie = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile191.png"
}
const ranger = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile192.png"
}
const executioner = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile193.png"
}
const berserker = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile194.png"
}
const knight = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile195.png"
}
const assassin = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile196.png"
}
const wizard = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile197.png"
}
const traveler = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile198.png"
}
const necromancer = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile199.png"
}

const enemy_types = {
	player_types_enum.soldier: soldier,
	player_types_enum.valkyrie: valkyrie,
	player_types_enum.ranger: ranger,
	player_types_enum.executioner: executioner,
	player_types_enum.berserker: berserker,
	player_types_enum.knight: knight,
	player_types_enum.wizard: wizard,
	player_types_enum.traveler: traveler,
	player_types_enum.necromancer: necromancer
}
