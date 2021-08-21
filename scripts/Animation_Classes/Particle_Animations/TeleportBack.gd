extends Node2D

class_name TeleportBack

var ani_spriteR
var ani_spriteL
var start_pos
var animation_steps = 20

func _init(new_pos: Vector2):
	start_pos = new_pos
	pass

func _ready():
	z_index = 5
	
	ani_spriteR = AnimatedSprite.new()
	ani_spriteR.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_spriteR.set_frame(49)
	add_child(ani_spriteR)
	
	ani_spriteL = AnimatedSprite.new()
	ani_spriteL.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_spriteL.set_frame(49)
	add_child(ani_spriteL)
	
	ani_spriteR.position.x += 25
	ani_spriteL.position.x -= 25
	
	var ani_timer = Timer.new()
	add_child(ani_timer)
	ani_timer.set_wait_time(0.05)
	ani_timer.set_one_shot(false)
	ani_timer.connect("timeout", self, "animation_step")
	ani_timer.start()
	
	position = start_pos
	pass

func animation_step():
	ani_spriteR.position.x -= 2.5
	ani_spriteL.position.x += 2.5
	ani_spriteR.modulate.a -= 0.1
	ani_spriteL.modulate.a -= 0.1
	animation_steps -= 1
	if animation_steps <= 0:
		end_animation()
	pass

func end_animation():
	queue_free()
