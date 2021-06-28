class_name Goblin

var string_name = "Goblin"
var sprite_frame = 1

var theme = Tile_Enums.tile_themes_enum.castle
var is_final_boss = false

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null
}
var special_moves_dict = {
	"attack": Animation_Enums.attack_dict.Tackle,
	"defend" : Animation_Enums.defend_dict.Weak,
	"turn" : Animation_Enums.turn_dict.Simple_Attack
}

#battle vars
var starting_health = 3
var speed = 0.5
