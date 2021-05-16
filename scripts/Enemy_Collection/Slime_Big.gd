class_name Slime_Big

export(String) var name = "Giant Slime"
export(int) var sprite_frame = 18

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 100,
	"attack": 50,
	"speed": 10,
	"loot" : 50,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
