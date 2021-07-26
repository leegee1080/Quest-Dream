extends Node2D

class_name Tile_Enums

enum tile_themes_enum{
	castle,
	forest,
	grave,
	mountain,
	swamp
}
enum tile_directions_enum{
	cross,
	elbow,
	straight,
	tee,
	impass,
	boss,
	terminal
}
enum center_type_enum{
	none,
	consumable,
	treasure,
	timedspike,
	moneypile,
	moneychest,
	reverse,
	kill,
	fight,
	switch,
	patrol,
	impass,
	key,
	keygate
}
const center_classes = {
	center_type_enum.none: null, #there is never going to be a class here
	center_type_enum.consumable: null, #this is overwritten by the chosen player class
	center_type_enum.treasure: Money_Coins,
	center_type_enum.timedspike: Bad_TimedSpike,
	center_type_enum.moneypile: Money_Pile,
	center_type_enum.moneychest: Money_Chest,
	center_type_enum.reverse: Safe_Reverse,
	center_type_enum.kill: Bad_Kill,
	center_type_enum.fight: null,
	center_type_enum.switch: null,
	center_type_enum.patrol: null,
	center_type_enum.impass: null, #there is never going to be a class here
	center_type_enum.key: Money_Key,
	center_type_enum.keygate: Safe_Keygate
}

#Chances To Spawn
const tile_path_chances = [
	[1, tile_directions_enum.cross],
	[3, tile_directions_enum.elbow],
	[2, tile_directions_enum.tee],
	[2, tile_directions_enum.straight]
]
const tile_center_chances = [
	[10, center_type_enum.none],
	[2, center_type_enum.consumable],
	[1, center_type_enum.treasure]
]
const premade_tile_center_chances = [
	[10, center_type_enum.treasure],
	[7, center_type_enum.timedspike],
	[10, center_type_enum.moneypile],
	[10, center_type_enum.moneychest],
	[10, center_type_enum.reverse],
	[2, center_type_enum.kill],
	[7, center_type_enum.fight],
	[5, center_type_enum.switch],
	[1, center_type_enum.patrol],
	[20, center_type_enum.impass],
	[5, center_type_enum.key],
	[10, center_type_enum.keygate]
]
