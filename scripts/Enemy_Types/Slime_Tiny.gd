class_name Slime_Tiny

export(String) var name = "Slime"
export(int) var sprite_frame = 17

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 40,
	"attack": 10,
	"speed": 5,
	"loot" : 10,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
