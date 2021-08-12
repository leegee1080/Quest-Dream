extends Node2D

class_name Traveler

const sprite_frame = 0
const string_name = "Traveler"
const unlock_cost = 70

const special_animations_dict = {
	"walk": "hop_walk",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_sidehop"
}

#ingame vars
const t_turn_right = true
const starting_attack_power = 1
const starting_consumable_amt = 10
const speed = 0.04
const consumable_class = Consume_Hearts

#combat vars
const fight_class = Fight_Normal

#gimmick
const gimmick_class = Gimmick_Normal

#action vars
const action_cost = 1
const action_class = Action_Place_Tile
const tile_direction = Tile_Enums.tile_directions_enum.cross
const tile_center = Tile_Enums.center_type_enum.none
