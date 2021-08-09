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
var starting_attack_power = 5
var starting_consumable_amt = 5
var consumable_class = Consume_Hearts

#action vars
var action_cost = 2
var tile_direction = Tile_Enums.tile_directions_enum.elbow
var tile_center = Tile_Enums.center_type_enum.none
