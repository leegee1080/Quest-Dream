class_name Player_Enums

enum player_types_enum{
	traveler,
	assassin,
	valkyrie,
	ranger,
	executioner,
	berserker,
	knight,
	wizard,
	necromancer
}
const player_types_dict = {
	player_types_enum.traveler: Traveler,
	player_types_enum.assassin: Assassin,
	player_types_enum.valkyrie: Valkyrie,
	player_types_enum.ranger: Ranger,
	player_types_enum.executioner: Executioner,
	player_types_enum.berserker: Berserker,
	player_types_enum.knight: Knight,
	player_types_enum.wizard: Wizard,
	player_types_enum.necromancer: Necromancer
}

const player_types_string_dict = {
	"traveler": [Traveler, player_types_enum.traveler],
	"assassin": [Assassin, player_types_enum.assassin],
	"valkyrie": [Valkyrie, player_types_enum.valkyrie],
	'ranger': [Ranger, player_types_enum.ranger],
	"executioner": [Executioner, player_types_enum.executioner],
	"berserker": [Berserker, player_types_enum.berserker],
	"knight": [Knight, player_types_enum.knight],
	"wizard": [Wizard, player_types_enum.wizard],
	"necromancer": [Necromancer, player_types_enum.necromancer]
}
