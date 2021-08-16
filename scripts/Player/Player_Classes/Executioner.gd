extends Node2D

class_name Executioner

const sprite_frame = 4
const string_name = "Executioner"
const unlock_cost = 120

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_twohop"
}

const t_turn_right = false
const starting_attack_power = 1
const starting_consumable_amt = 5
const speed = 0.06
const consumable_class = Consume_Hearts

var kills = 0

#combat vars
const fight_class = Fight_InstantKill_GainDoubleMoney

#gimmick
const gimmick_class = Gimmick_Exec

#action vars
const action_cost = 1
const action_class = Action_Place_Tile
const tile_direction = Tile_Enums.tile_directions_enum.cross
const tile_center = Tile_Enums.center_type_enum.timedspike
