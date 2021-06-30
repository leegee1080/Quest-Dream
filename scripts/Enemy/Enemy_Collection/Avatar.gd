class_name Avatar

var string_name = "Avatar of Death"
var sprite_frame = 0

var theme = Tile_Enums.tile_themes_enum.castle
var is_final_boss = true

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null
}
var special_moves_dict = {
	"attack": Animation_Enums.attack_dict.tackle,
	"defend" : Animation_Enums.defend_dict.weak,
	"turn" : Animation_Enums.turn_dict.simple_attack
}

#battle vars
var starting_health = 3
var speed = 1
