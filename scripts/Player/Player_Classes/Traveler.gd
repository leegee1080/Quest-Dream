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
var t_turn_right = true
var starting_attack_power = 1
var starting_consumable_amt = 10
var consumable_class = Consume_Hearts

#action vars
var action_cost = 1
var tile_direction = Tile_Enums.tile_directions_enum.cross
var tile_center = Tile_Enums.center_type_enum.none
