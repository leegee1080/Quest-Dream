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
const special_moves_dict = {
	"attack": "tackle_p",
	"dodge" : "dodge_roll"
}

#battle vars
var starting_attack_power = 1

var starting_attack_recharge_amount = 3
var starting_attack_recharge_speed = 1
var starting_attack_charges = 3
var attack_sprite_frame = 2

var starting_dodge_recharge_amount = 1
var starting_dodge_recharge_speed = 0.5
var starting_dodge_charges = 3
var dodge_sprite_frame = 50

var starting_attack_range = 10 #this is the distance from the enemy y-axis giving the player more time to react

var starting_consumable_amt = 3
var consumable_class = Consume_Hearts

#map vars
var money_class = Money_Coins

#level up choices (always 2 to choose from) (each choice will instance a class that will modify the character and then remove itself)
var level_up_choices_array = [
	null, #level 0
]
