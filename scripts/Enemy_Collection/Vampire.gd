class_name Vampire

export(String) var name = "Vampire"
export(int) var sprite_frame = 24

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave,
	Tile_Enums.tile_themes_enum.mountain
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 50,
	"attack": 30,
	"speed": 50,
	"loot" : 30,
}
var special_animations_dict = {
	"walk": GlobalVars.ani_dict.wiggle_in_place,
	"melee": GlobalVars.ani_dict.melee_tackle,
	"ranged": null,
	"magic": null,
	"injure": GlobalVars.ani_dict.hit_color_change,
	"death": GlobalVars.ani_dict.death_flip_red,
	"happy": null
}

func attack():
	print(name + " attacked")

func hit():
	print(name + " taken hit")
