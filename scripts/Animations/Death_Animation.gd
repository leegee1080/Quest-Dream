extends Node2D

class_name Death_Animation

const hit_ani_color_list = [
	Color(1,1,1,1),
	Color(1,0,0,1)
]


var ani_sprite

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite

func _ready():
	return

func play_death_animation():
	ani_sprite.modulate = Color(1,0,0,1)
