extends Node

var current_stage = 1
var current_theme = Tile_Enums.tile_themes_enum.castle

var main_node_ref
var player_node_ref
var stage_enemies_dict = { #this dict is filled at start of the main class, there is a list of all possible enemies per level of this theme
	0 : [],#this is the index of the boss enemies
	1 : [],
	2 : [],
	3 : [],
	4 : []
}
var tile_path_type_chance_array = []
var tile_center_chance_array = []
const ani_dict = {#dictionary of all the animation classes
	"wiggle_in_place" : Walking_Animation,
	"melee_tackle" : Melee_Animation,
	"range" : null,
	"magic" : null,
	"hit_color_change" : Hit_Color_Animation,
	"death_flip_red" : Death_Animation
}
