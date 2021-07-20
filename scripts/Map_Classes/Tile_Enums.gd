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
	reverse,
	kill,
	fight,
	switch,
	patrol,
	impass,
	keygate
}
const center_classes = {
	center_type_enum.none: null,
	center_type_enum.consumable: null,
	center_type_enum.treasure: Money_Coins,
	center_type_enum.timedspike: null,
	center_type_enum.moneypile: Money_Pile,
	center_type_enum.reverse: null,
	center_type_enum.kill: null,
	center_type_enum.fight: null,
	center_type_enum.switch: null,
	center_type_enum.patrol: null,
	center_type_enum.impass: null,
	center_type_enum.keygate: null
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
	[10, center_type_enum.reverse],
	[2, center_type_enum.kill],
	[7, center_type_enum.fight],
	[5, center_type_enum.switch],
	[1, center_type_enum.patrol],
	[20, center_type_enum.impass],
	[1, center_type_enum.keygate]
]
