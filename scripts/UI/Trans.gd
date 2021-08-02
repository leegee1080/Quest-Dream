extends Node2D

class_name Trans

var trans_speed = 1.0
var trans_image = preload("res://assets/visuals/trans_image.png")

var trans_sprite
var trans_step_timer
var trans_step_time = 0.01

func _ready():
	name = "ScreenTrans"
	
	trans_sprite = Sprite.new()
	trans_sprite.centered = false
	trans_sprite.texture = trans_image
	trans_sprite.offset = Vector2(304,0)
	add_child(trans_sprite)
	trans_sprite.z_index = 100
	
	trans_step_timer = Timer.new()
	add_child(trans_step_timer)
	trans_step_timer.set_wait_time(trans_step_time)
	trans_step_timer.set_one_shot(false)
	trans_step_timer.connect("timeout", self, "trans_step")
	trans_step_timer.stop()

func run_trans():
	trans_step_timer.stop()
	print("Start Trans Ani")
	trans_sprite.position = Vector2(0,0)
	trans_step_timer.start()
	pass

func trans_step():
	trans_sprite.translate(Vector2(-1,0)*18)
	if trans_sprite.position.x <= -1250:
		trans_step_timer.stop()
		trans_sprite.position = Vector2(0,0)
	pass
