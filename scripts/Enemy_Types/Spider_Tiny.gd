class_name Spider_Tiny

export(String) var name = "Spider"
export(int) var sprite_frame = 14

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 1,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
