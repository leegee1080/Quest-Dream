extends Node2D

class_name Walking_Animation

const walk_ani_pos_list = [
	[Vector2(0,0), 0],
	[Vector2(-1,-2), 0.1],
	[Vector2(0,0), 0],
	[Vector2(1,-2), -0.1]
]


var ani_sprite
var walk_animation_step = (walk_ani_pos_list.size()-1)
var walk_animation_timer

var walk_animation_speed

func _init(new_ani_sprite, new_walk_speed):
	ani_sprite = new_ani_sprite
	walk_animation_speed = new_walk_speed

func _ready():
	walk_animation_timer = Timer.new()
	add_child(walk_animation_timer)
	walk_animation_timer.set_wait_time(walk_animation_speed)
	walk_animation_timer.set_one_shot(false) # Make sure it loops
	walk_animation_timer.connect("timeout", self, "walk_cycle")
	walk_animation_timer.stop()

func walk_cycle():
	ani_sprite.position = walk_ani_pos_list[walk_animation_step][0]
	ani_sprite.rotation = walk_ani_pos_list[walk_animation_step][1]
	walk_animation_step -= 1
	if walk_animation_step < 0:
		walk_animation_step = (walk_ani_pos_list.size()-1)

func start_walk():
	walk_animation_timer.start()

func stop_walk():
	walk_animation_timer.stop()
