extends Node2D

class_name Walking_Animation

const walk_ani_pos_list = [
	[Vector2(0,0), 0],
	[Vector2(-1,-2), 0.1],
	[Vector2(0,0), 0],
	[Vector2(1,-2), -0.1]
]


var ani_sprite
var walk_animation_step = 0
var walk_animation_timer

var walk_animation_speed = 0.1

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite

func _ready():
	walk_animation_timer = Timer.new()
	add_child(walk_animation_timer)
	walk_animation_timer.add_to_group("timers")
	walk_animation_timer.set_wait_time(walk_animation_speed)
	walk_animation_timer.set_one_shot(false) # Make sure it loops
	walk_animation_timer.connect("timeout", self, "walk_cycle")

func walk_cycle():
	ani_sprite.position = walk_ani_pos_list[walk_animation_step][0]
	ani_sprite.rotation = walk_ani_pos_list[walk_animation_step][1]
	walk_animation_step -= 1
	if walk_animation_step < 0:
		walk_animation_step = (walk_ani_pos_list.size()-1)

func play_animation():
	walk_animation_timer.start()

func stop_animation():
	walk_animation_timer.stop()
	ani_sprite.position = walk_ani_pos_list[0][0]
	ani_sprite.rotation = walk_ani_pos_list[0][1]
