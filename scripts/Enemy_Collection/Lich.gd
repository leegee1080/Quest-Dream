class_name Lich

export(String) var name = "Lich"
export(int) var sprite_frame = 25

var theme_list = [
	Tile_Enums.tile_themes_enum.swamp,
	Tile_Enums.tile_themes_enum.grave
]
var is_boss = true
var difficulty = 0

var stat_dict = {
	"health": 60,
	"attack": 60,
	"speed": 60,
	"loot" : 60,
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
