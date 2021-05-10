class_name Golem_God

export(String) var name = "Golem God"
export(int) var sprite_frame = 27

var theme_list = [
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 150,
	"attack": 80,
	"speed": 80,
	"loot" : 80,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
