extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": null
}

#battle vars
var starting_attack_power = 1

var starting_consumable_amt = 3
var consumable_class = Consume_Hearts
