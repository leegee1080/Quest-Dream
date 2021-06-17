extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null,
	"attack": null,
	"dodge" : null
}

#battle vars
var starting_attack_power
var starting_attack_recharge_speed
var starting_attack_charges
var starting_dodge_recharge_speed
var starting_dodge_charges
var starting_attack_range #this is the distance from the enemy y-axis giving the player more time to react
var starting_consumable_amt = 3
var consumable_class = Consume_Hearts
var money_class = Money_Coins

#level up choices (always 2 to choose from) (each choice will instance a class that will modify the character and then remove itself)
var level_up_choices_array = [
	null, #level 0
]
