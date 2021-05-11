class_name Alien_God

export(String) var name = "Alien God"
export(int) var sprite_frame = 28

var theme_list = [
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 100,
	"attack": 100,
	"speed": 100,
	"loot" : 100,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
