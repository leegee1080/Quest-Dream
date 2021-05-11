class_name Monkey

export(String) var name = "Monkey"
export(int) var sprite_frame = 3

var theme_list = [
	Tile_Enums.tile_themes_enum.forest
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 6,
	"loot" : 1,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
