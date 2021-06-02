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
	treasure
#	shop,#no longer used
#	silly #no longer used
}

#Chances To Spawn
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
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.none,
#	center_type_enum.rest,
#	center_type_enum.battle,
#	center_type_enum.treasure,
##	center_type_enum.silly
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
	center_type_enum.treasure,
#	center_type_enum.silly
]
