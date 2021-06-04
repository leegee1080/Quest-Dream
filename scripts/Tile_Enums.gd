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
	rest,
	battle,
	treasure,
	boss
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
	[2, center_type_enum.rest],
	[2, center_type_enum.battle],
	[1, center_type_enum.treasure]
]
