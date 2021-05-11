class_name Eye

export(String) var name = "Specter Eye"
export(int) var sprite_frame = 16

var theme_list = [
	Tile_Enums.tile_themes_enum.grave
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 10,
	"attack": 4,
	"speed": 4,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
