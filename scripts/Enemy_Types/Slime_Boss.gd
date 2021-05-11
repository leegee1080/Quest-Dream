class_name Slime_Boss

export(String) var name = "Slime Boss"
export(int) var sprite_frame = 20

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = true
var difficulty = 1

var stat_dict = {
	"health": 1000,
	"attack": 50,
	"speed": 20,
	"loot" : 50,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
