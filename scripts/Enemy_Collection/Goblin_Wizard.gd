class_name Goblin_Wizard

export(String) var name = "Goblin Wizard"
export(int) var sprite_frame = 2

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp
]
var is_boss = false
var difficulty = 2

var stat_dict = {
	"health": 5,
	"attack": 10,
	"speed": 8,
	"loot" : 10,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
