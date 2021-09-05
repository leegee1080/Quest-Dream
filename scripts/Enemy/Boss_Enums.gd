extends Node2D

class_name Boss_Enums

enum boss_types_enum{
	giantspider,
	gianteye
}
const boss_types_dict = {
	boss_types_enum.giantspider: Boss_Forest_Spider,
	boss_types_enum.gianteye: Boss_Giant_Eye
}
const boss_theme_dict = {
	Tile_Enums.tile_themes_enum.forest: [Boss_Forest_Spider],
	Tile_Enums.tile_themes_enum.mountain: [Boss_Giant_Eye],
	Tile_Enums.tile_themes_enum.swamp: [null],
	Tile_Enums.tile_themes_enum.grave: [null],
	Tile_Enums.tile_themes_enum.castle: [null]
}
