extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

var starting_health = 10
var starting_items = []
var attack_class = Battle_Enums.attack_dict.Tackle
var defend_class = Battle_Enums.defend_dict.Weak
var turn_class = Battle_Enums.turn_dict.Simple_Attack

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null
}
