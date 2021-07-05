extends Node

const stage_order = { #the stage number and corresponding theme 
	1: Tile_Enums.tile_themes_enum.forest,
	6: Tile_Enums.tile_themes_enum.mountain,
	11: Tile_Enums.tile_themes_enum.swamp,
	16: Tile_Enums.tile_themes_enum.grave,
	21: Tile_Enums.tile_themes_enum.castle
}

var current_stage: int = 1
var current_theme = Tile_Enums.tile_themes_enum.castle

var money_gained_this_run = 0

var player_type_class_storage
var main_node_ref
var player_node_ref
var room_player_node_ref
var player_consumable_amount = 0

var stage_enemies_dict = { #this dict is filled at start of the main class, there is an array for each them of sub_boss[0] and bosses[1]
	Tile_Enums.tile_themes_enum.forest : [[],[]],
	Tile_Enums.tile_themes_enum.mountain : [[],[]],
	Tile_Enums.tile_themes_enum.swamp : [[],[]],
	Tile_Enums.tile_themes_enum.grave : [[],[]],
	Tile_Enums.tile_themes_enum.castle : [[],[]]
}

var battle_participants_node_array = []

var tile_path_type_chance_array = []
var tile_center_chance_array = []
const ani_dict = {#dictionary of all the animation classes
	"wiggle_in_place" : Walking_Animation,
	"melee_tackle" : Tackle_Attack_1,
	"range" : null,
	"magic" : null,
	"hit_color_change" : Hit_Color_Animation,
	"death_flip_red" : Death_Animation
}
