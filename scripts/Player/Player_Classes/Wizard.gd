extends Node2D

class_name Wizard

const sprite_frame = 7
const string_name = "Wizard"
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
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Wiz

#action vars
const action_cost = 1
const action_class = Action_TeleAll_Tile
const tile_direction = Tile_Enums.tile_directions_enum.cross
const tile_center = Tile_Enums.center_type_enum.none
