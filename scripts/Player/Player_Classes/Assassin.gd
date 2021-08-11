extends Node2D

class_name Assassin

const sprite_frame = 6
const string_name = "Assassin"
const unlock_cost = 100

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_flip"
}

#ingame vars
const t_turn_right = false
const starting_attack_power = 5
const starting_consumable_amt = 5
const speed = 0.02
const consumable_class = Consume_Hearts

#combat vars
const fight_class = Normal_Fight

#gimmick
const gimmick_class = null

#action vars
const action_cost = 1
const action_class = Action_Turn_Around
