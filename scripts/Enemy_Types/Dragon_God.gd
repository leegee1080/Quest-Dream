class_name Dragon_God

export(String) var name = "Dragon God"
export(int) var sprite_frame = 29

var theme_list = [
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 200,
	"attack": 100,
	"speed": 110,
	"loot" : 100,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
