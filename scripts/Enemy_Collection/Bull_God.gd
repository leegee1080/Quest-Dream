class_name Bull_God

export(String) var name = "Bull God"
export(int) var sprite_frame = 26

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 100,
	"attack": 100,
	"speed": 90,
	"loot" : 100,
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
