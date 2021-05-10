class_name Snake

export(String) var name = "Snake"
export(int) var sprite_frame = 13

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 4,
	"attack": 4,
	"speed": 3,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
