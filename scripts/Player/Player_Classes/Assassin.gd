extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

var special_animations_dict = {
	"walk": Animation_Enums.ani_dict.wiggle_in_place,
	"death": Animation_Enums.ani_dict.death_flip_red,
	"injure": Animation_Enums.ani_dict.hit_color_change,
	"happy": null
}

#battle vars
var starting_consumable_amt = 3
var consumable_class = Consume_Hearts
var money_class = Money_Coins
var speed = 0.5
var starting_items = []
var attack_class = Battle_Enums.attack_dict.Tackle
var defend_class = Battle_Enums.defend_dict.Weak
var turn_class = Battle_Enums.turn_dict.Simple_Attack

#level up choices (always 2 to choose from) (each choice will instance a class that will modify the character and then remove itself)
var level_up_choices_array = [
	null, #there is no 0 level
	[["New Attack: Tackle.", Level_Up_Enums.level_up_classes_dict.swap_ability, attack_class, Battle_Enums.attack_dict.Tackle], ["Increase Health by 1.", Level_Up_Enums.level_up_classes_dict.stat_up, starting_consumable_amt, 1]],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	["Sometimes Dodge", "3 Attacks"],
	null #there is no 26th level
]
