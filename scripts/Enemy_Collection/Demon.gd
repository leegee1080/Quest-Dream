class_name Demon

export(String) var name = "Demon"
export(int) var sprite_frame = 23

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 18,
	"attack": 14,
	"speed": 15,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
