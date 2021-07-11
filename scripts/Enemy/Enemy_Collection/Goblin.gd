class_name Goblin

var string_name = "Goblin"
var sprite_frame = 1

var theme = Tile_Enums.tile_themes_enum.forest
var is_final_boss = false
var is_minion = false

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": null
}
var special_moves_dict = {
	"attack": "tackle",
	"defend" : "weak",
	"turn" : "attack_then_move_random_direction"
}

#battle vars
var damage = 1
var starting_health = 3
var speed = 5
