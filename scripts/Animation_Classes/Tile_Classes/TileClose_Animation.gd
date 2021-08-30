extends Node2D

class_name TileClose_Animation

var tick_timer
var ani_sprite

var close_speed = 0.5
var current_frame = 98
var lowest_frame = 101

func _init(is_vert: bool, new_close_speed: float):
	if is_vert:
		close_speed = new_close_speed
		current_frame = 98
		lowest_frame = 101
	else:
		close_speed = new_close_speed
		current_frame = 94
		lowest_frame = 97


func _ready():
	z_index = 5
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/tile_frames.tres"))
	
	tick_timer = Timer.new()
	add_child(tick_timer)
	tick_timer.set_wait_time(close_speed)
	tick_timer.set_one_shot(false)
	tick_timer.connect("timeout", self, "animation_step")
	
	var delay_timer = Timer.new()
	add_child(delay_timer)
	delay_timer.set_wait_time(6)
	delay_timer.set_one_shot(true)
	delay_timer.connect("timeout", self, "delayed_start")
	delay_timer.start()

func delayed_start():
	add_child(ani_sprite)
	ani_sprite.set_frame(current_frame)
	tick_timer.start()

func animation_step():
	ani_sprite.set_frame(current_frame)
	current_frame +=1
	if current_frame > lowest_frame:
		get_parent().queue_free()
	pass
