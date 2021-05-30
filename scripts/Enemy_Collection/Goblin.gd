class_name Goblin

export(String) var name = "Goblin"
export(int) var sprite_frame = 1

var theme_list = [
	Tile_Enums.tile_themes_enum.forest,
	Tile_Enums.tile_themes_enum.swamp
]
var is_boss = false
var difficulty = 1

var stat_dict = {
	"health": 2,
	"attack": 2,
	"speed": 2,
	"loot" : 1,
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
