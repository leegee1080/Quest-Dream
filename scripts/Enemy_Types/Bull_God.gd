class_name Bull_God

export(String) var name = "Bull God"
export(int) var sprite_frame = 26

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 100,
	"attack": 100,
	"speed": 90,
	"loot" : 100,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
