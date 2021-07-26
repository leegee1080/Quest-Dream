extends Node2D

class_name Bad_TimedSpike

var sound

var ani_sprite
var item_frame = 85
var spike_out_frame = 86
const can_pick_up = true
var changes_direction = false
var my_spike_timer
const spike_toggle_speed = 5.0
var is_spike_out = true

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(spike_out_frame)
	add_child(ani_sprite)
	
	my_spike_timer = Timer.new()
	my_spike_timer.name = "Start Timer"
	add_child(my_spike_timer)
	my_spike_timer.add_to_group("timers")
	my_spike_timer.set_wait_time(spike_toggle_speed)
	my_spike_timer.set_one_shot(false)
	my_spike_timer.connect("timeout", self, "spike_toggle")
	my_spike_timer.start()

func spike_toggle():
	if is_spike_out:
		is_spike_out = false
		ani_sprite.set_frame(item_frame)
	else:
		is_spike_out = true
		ani_sprite.set_frame(spike_out_frame)
	pass

func pick_up():
	if is_spike_out:
		GlobalVars.player_node_ref.take_hit(2)
	#play sound
	return changes_direction

func finish_pickup_animation():
	pass
