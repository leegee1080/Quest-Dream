class_name Human_Wizard

export(String) var name = "Wizard"
export(int) var sprite_frame = 5

var theme_list = [
	Tile_Enums.tile_themes_enum.castle
]
var is_boss = false
var difficulty = 3

var stat_dict = {
	"health": 60,
	"attack": 30,
	"speed": 40,
	"loot" : 40,
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
