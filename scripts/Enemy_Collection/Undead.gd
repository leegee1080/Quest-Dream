class_name Undead

export(String) var name = "Undead"
export(int) var sprite_frame = 22

var theme_list = [
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 20,
	"attack": 10,
	"speed": 5,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
