extends Node2D

class_name Hit_Color_Animation

const hit_ani_color_list = [
	Color(1,1,1,1),
	Color(1,0,0,1)
]


var ani_sprite 
var hit_animation_step = 0
var hit_animation_timer
var hit_animation_total_timer

var hit_animation_speed = .1
var hit_animation_time = .5

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite

func _ready():
	hit_animation_total_timer = Timer.new()
	add_child(hit_animation_total_timer)
	hit_animation_total_timer.add_to_group("timers")
	hit_animation_total_timer.set_wait_time(hit_animation_time)
	hit_animation_total_timer.set_one_shot(true)
	hit_animation_total_timer.connect("timeout", self, "stop_hit")
	
	hit_animation_timer = Timer.new()
	add_child(hit_animation_timer)
	hit_animation_timer.add_to_group("timers")
	hit_animation_timer.set_wait_time(hit_animation_speed)
	hit_animation_timer.set_one_shot(false) # Make sure it loops
	hit_animation_timer.connect("timeout", self, "hit_cycle")

func hit_cycle():
	ani_sprite.modulate = hit_ani_color_list[hit_animation_step]
	hit_animation_step -= 1
	if hit_animation_step < 0:
		hit_animation_step = (hit_ani_color_list.size()-1)

func start_hit():
	hit_animation_total_timer.start()
	hit_animation_timer.start()

func stop_hit():
	hit_animation_total_timer.stop()
	hit_animation_timer.stop()
	ani_sprite.modulate = hit_ani_color_list[0]
