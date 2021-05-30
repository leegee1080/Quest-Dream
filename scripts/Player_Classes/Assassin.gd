extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

var stat_dict = {
	"health": 10,
	"attack": 1,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
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

func _init(ani_sprite):
	name = string_name
