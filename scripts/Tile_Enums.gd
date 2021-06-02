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
#const center_tile_chances = [
#	[1, tile_directions_enum.cross],
#	[3, tile_directions_enum.elbow],
#	[2, tile_directions_enum.tee],
#	[2, tile_directions_enum.straight]
#]
const tile_chances = [
	tile_directions_enum.cross,
	tile_directions_enum.elbow,
	tile_directions_enum.elbow,
	tile_directions_enum.elbow,
	tile_directions_enum.tee,
	tile_directions_enum.tee,
	tile_directions_enum.straight,
	tile_directions_enum.straight
]
#const center_tile_chances = [
#	[10, center_type_enum.none],
#	[1, center_type_enum.rest],
#	[1, center_type_enum.battle],
#	[1, center_type_enum.treasure]
#]
const center_tile_chances = [
	center_type_enum.none,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.battle,
	center_type_enum.rest,
	center_type_enum.battle,
	center_type_enum.treasure
]
