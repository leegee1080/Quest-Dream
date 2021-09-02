extends Node2D

class_name Boss_Enums

enum boss_types_enum{
	giantspider
}
const boss_types_dict = {
	boss_types_enum.giantspider: Boss_Forest_Spider
}
const boss_theme_dict = {
	Tile_Enums.tile_themes_enum.forest: [Boss_Forest_Spider],
	Tile_Enums.tile_themes_enum.mountain: [],
	Tile_Enums.tile_themes_enum.swamp: [],
	Tile_Enums.tile_themes_enum.grave: [],
	Tile_Enums.tile_themes_enum.castle: []
}
