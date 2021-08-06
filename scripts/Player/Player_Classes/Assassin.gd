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
var t_turn_right = false
var starting_attack_power = 1
var starting_consumable_amt = 100
var consumable_class = Consume_Hearts

#action vars
var action_cost = 1
var tile_direction = Tile_Enums.tile_directions_enum.cross
var tile_center = Tile_Enums.center_type_enum.none
