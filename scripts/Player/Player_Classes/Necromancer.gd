extends Node2D

class_name Necromancer

const sprite_frame = 9
const string_name = "Necromancer"
const unlock_cost = 200

const special_animations_dict = {
	"walk": "float_walk",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_twohop"
}

#ingame vars
const t_turn_right = false
const starting_attack_power = 2
const starting_consumable_amt = 2
const speed = 0.04
const consumable_class = Consume_Hearts

var kills = 0

#combat vars
const fight_class = Fight_InstantKill_GainConsume

#gimmick
const gimmick_class = Gimmick_Normal

#action vars
const action_cost = 0
const action_class = Action_KillSelf_GetPaid
