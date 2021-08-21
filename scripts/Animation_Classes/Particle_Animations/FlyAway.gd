extends Node2D

class_name FlyAway

var ani_spriteR
var start_pos
var animation_steps = 20

var particle_directions = [1,-1]

func _init(new_pos: Vector2):
	start_pos = Vector2(new_pos.x, new_pos.y + 5)
	pass

func _ready():
	z_index = 5
	
	ani_spriteR = AnimatedSprite.new()
	ani_spriteR.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_spriteR.set_frame(50)
	add_child(ani_spriteR)
	
	var ani_timer = Timer.new()
	add_child(ani_timer)
	ani_timer.set_wait_time(0.05)
	ani_timer.set_one_shot(false)
	ani_timer.connect("timeout", self, "animation_step")
	ani_timer.start()
	randomize()
	particle_directions.shuffle()
	
	position = start_pos
	pass

func animation_step():
	ani_spriteR.position.x += 1.5 * particle_directions[0]
	ani_spriteR.position.y -= 1
	ani_spriteR.modulate.a -= 0.1
	animation_steps -= 1
	if animation_steps <= 0:
		end_animation()
	pass

func end_animation():
	queue_free()
