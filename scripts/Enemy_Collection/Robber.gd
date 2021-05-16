class_name Robber

export(String) var name = "Highway Man"
export(int) var sprite_frame = 4

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 8,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
