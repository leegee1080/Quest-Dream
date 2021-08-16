extends Node2D

class_name AttackUp

var ani_sprite
var start_pos
var animation_steps = 10

func _init(new_pos: Vector2):
	start_pos = new_pos
	pass

func _ready():
	z_index = 5
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(5)
	add_child(ani_sprite)
	
	var ani_timer = Timer.new()
	add_child(ani_timer)
	ani_timer.set_wait_time(0.1)
	ani_timer.set_one_shot(false)
	ani_timer.connect("timeout", self, "animation_step")
	ani_timer.start()
	
	position = start_pos
	pass

func animation_step():
	position.y -= 1
	ani_sprite.modulate.a -= 0.1
	animation_steps -= 1
	if animation_steps <= 0:
		end_animation()
	pass

func end_animation():
	queue_free()
