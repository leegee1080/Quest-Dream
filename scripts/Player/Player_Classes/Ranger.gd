extends Node2D

class_name Ranger

const sprite_frame = 2
const string_name = "Ranger"
const unlock_cost = 30

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_twohop"
}

#ingame vars
const t_turn_right = true
const starting_attack_power = 3
const starting_consumable_amt = 6
const speed = 0.03
const consumable_class = Consume_Hearts

var kills = 0

#combat vars
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Normal

#action vars
const action_cost = 2
const action_class = Action_Place_Tile
const tile_direction = Tile_Enums.tile_directions_enum.cross
const tile_center = Tile_Enums.center_type_enum.key
