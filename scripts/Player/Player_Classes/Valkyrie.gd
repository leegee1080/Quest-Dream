extends Node2D

class_name Valkyrie

const sprite_frame = 1
const string_name = "Valkyrie"
const unlock_cost = 120

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_twohop"
}

#ingame vars
const t_turn_right = true
const starting_attack_power = 5
const starting_consumable_amt = 20
const speed = 0.04
const consumable_class = Consume_Hearts

var kills = 0

#combat vars
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Valk

#action vars
const action_cost = 1
const action_class = Action_Place_Tile
const tile_direction = Tile_Enums.tile_directions_enum.cross
const tile_center = Tile_Enums.center_type_enum.fight
