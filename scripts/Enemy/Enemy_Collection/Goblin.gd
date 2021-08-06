class_name Goblin

var string_name = "Goblin"
var sprite_frame = 21

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
var starting_health = 5
var speed = .5
var reward = 10
