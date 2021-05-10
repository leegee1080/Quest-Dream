class_name Vampire

export(String) var name = "Vampire"
export(int) var sprite_frame = 24

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 50,
	"attack": 30,
	"speed": 50,
	"loot" : 30,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
