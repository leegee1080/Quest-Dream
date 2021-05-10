class_name Spider_Big

export(String) var name = "Giant Spider"
export(int) var sprite_frame = 15

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 10,
	"attack": 4,
	"speed": 10,
	"loot" : 4,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
