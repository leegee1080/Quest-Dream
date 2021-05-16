class_name Dog

export(String) var name = "Dog"
export(int) var sprite_frame = 12

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.grave
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 2,
	"attack": 2,
	"speed": 4,
	"loot" : 1,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
