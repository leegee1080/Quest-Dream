extends Node2D

class_name Berserker

const sprite_frame = 3
const string_name = "Berserker"
const unlock_cost = 120

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_twohop"
}

#ingame vars
const t_turn_right = false
const starting_attack_power = 5
const starting_consumable_amt = 10
const speed = 0.02
const consumable_class = Consume_Hearts

var kills = 0

#combat vars
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Ber

#action vars
const action_cost = 1
const action_class = Action_Killall_Minions
