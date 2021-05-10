class_name Human_Wizard

export(String) var name = "Wizard"
export(int) var sprite_frame = 5

var theme_list = [
	Tile_Enums.tile_themes_enum.castle
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 60,
	"attack": 30,
	"speed": 40,
	"loot" : 40,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
