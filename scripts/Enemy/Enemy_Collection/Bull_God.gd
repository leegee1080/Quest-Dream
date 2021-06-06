class_name Bull_God

export(String) var name = "Bull God"
export(int) var sprite_frame = 26

var theme_list = [
	Tile_Enums.tile_themes_enum.castle,
	Tile_Enums.tile_themes_enum.forest
]
var is_boss = true
var difficulty = 0

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null
}

#battle vars
var starting_health = 10
var speed = 0.5
var starting_items = []
var attack_class = Battle_Enums.attack_dict.Tackle
var defend_class = Battle_Enums.defend_dict.Weak
var turn_class = Battle_Enums.turn_dict.Simple_Attack
