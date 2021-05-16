class_name Vines

export(String) var name = "Virulent Vines"
export(int) var sprite_frame = 19

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 50,
	"attack": 1,
	"speed": 1,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
