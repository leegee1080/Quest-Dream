class_name Human_Sorcerer

export(String) var name = "Sorcerer"
export(int) var sprite_frame = 6

var theme_list = [
	Tile_Enums.tile_themes_enum.castle
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 30,
	"attack": 60,
	"speed": 40,
	"loot" : 40,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
