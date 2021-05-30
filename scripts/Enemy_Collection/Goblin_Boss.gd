class_name Goblin_Boss

export(String) var name = "Goblin Boss"
export(int) var sprite_frame = 21

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 20,
	"attack": 10,
	"speed": 8,
	"loot" : 10,
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
