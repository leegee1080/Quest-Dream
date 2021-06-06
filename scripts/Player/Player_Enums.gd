class_name Player_Enums

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
const player_types_dict = {
	player_types_enum.soldier: Soldier,
	player_types_enum.valkyrie: Valkyrie,
	player_types_enum.ranger: Ranger,
	player_types_enum.executioner: Executioner,
	player_types_enum.berserker: Berserker,
	player_types_enum.knight: Knight,
	player_types_enum.assassin: Assassin,
	player_types_enum.wizard: Wizard,
	player_types_enum.traveler: Traveler,
	player_types_enum.necromancer: Necromancer
}
