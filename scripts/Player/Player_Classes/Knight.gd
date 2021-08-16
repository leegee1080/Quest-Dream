extends Node2D

class_name Knight

const sprite_frame = 5
const string_name = "Knight"
const unlock_cost = 150

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_flip"
}

#ingame vars
const t_turn_right = false
var starting_attack_power = 2
const starting_consumable_amt = 20
const speed = 0.04
const consumable_class = Consume_Swords

var kills = 0

#combat vars
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Knight

#action vars
const action_cost = 1
const action_class = Action_BoostAttackPower
