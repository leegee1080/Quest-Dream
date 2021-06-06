class_name Eye

export(String) var name = "Specter Eye"
export(int) var sprite_frame = 16

var theme_list = [
	Tile_Enums.tile_themes_enum.grave
]
var is_boss = false
var difficulty = 2

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
