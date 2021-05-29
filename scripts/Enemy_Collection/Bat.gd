class_name Bat

const name = "Bat"
const sprite_frame = 11

const theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
const is_boss = false
const difficulty = 1

var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 8,
	"loot" : 1,
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
