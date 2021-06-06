extends Node2D

class_name Room_Enums

#this for the sprite frame
const room_theme_dict = {
	Tile_Enums.tile_themes_enum.castle: 0,
	Tile_Enums.tile_themes_enum.forest: 1,
	Tile_Enums.tile_themes_enum.grave: 2,
	Tile_Enums.tile_themes_enum.mountain: 3,
	Tile_Enums.tile_themes_enum.swamp: 4
}

const room_type_dict = {
	Tile_Enums.center_type_enum.battle: Fight_Room,
	Tile_Enums.center_type_enum.treasure: Treasure_Room,
	Tile_Enums.center_type_enum.rest: Rest_Room,
	Tile_Enums.center_type_enum.boss: Boss_Room
}
