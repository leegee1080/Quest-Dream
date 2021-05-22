extends Node2D

class_name Assassin

var sprite_frame = 6
const string_name = "Assassin"

var stat_dict = {
	"health": 10,
	"attack": 1,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

const ani_dict = {
	"walk" : Walking_Animation,
	"melee" : null,
	"range" : null,
	"magic" : null,
	"hit" : Hit_Color_Animation,
	"death" : Death_Animation
}

var walk_animation
var melee_animation
var ranged_animation
var magic_animation
var hit_animation
var death_animation

func _init(ani_sprite):
	name = string_name
	
	walk_animation = ani_dict.walk.new(ani_sprite)
	walk_animation.name = "walk_ani"
	
	#melee_animation
	
	#range_animation
	
	#magic_animation
	
	hit_animation = ani_dict.hit.new(ani_sprite)
	hit_animation.name = "hit_ani"
	
	death_animation = ani_dict.death.new(ani_sprite)
	death_animation.name = "death_ani"
	pass

func _ready():
	add_child(walk_animation)
	add_child(hit_animation)
	#melee_animation
	#range_animation
	#magic_animation
	add_child(death_animation)
	pass

func melee_attack():
	print("player melee")

func ranged_attack():
	print("player melee")

func magic_attack():
	print("player melee")

func take_hit():
	hit_animation.start_hit()
	print("player took hit")

func die():
	hit_animation.stop_hit()
	death_animation.play_death_animation()
	print("player dead")
