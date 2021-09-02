class_name Minion_Spider

var string_name = "Little Spider"
var sprite_frame = 14

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_flip"
}

#map vars
var t_turn_right = false

#battle vars
var damage = 1
var starting_health = 1
var speed = 0.02
var reward = 1
