extends Node2D

class_name Message

var msg_speed = 1.0
var msg_image = preload("res://assets/visuals/msg_bg.png")

var msg_sprite
var msg_step_timer
const msg_step_time = 0.01

var midstop_timer
const midstop_time = 1

const starting_scroll_speed = 10
const starting_speed_mod = 0.12
var scroll_speed = starting_scroll_speed
var speed_mod = starting_speed_mod

#vars for text elements
var msg_rtl
const rect_size = Vector2(1650,300)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const text_scale = 0.15

func _ready():
	name = "ScreenMsg"
	z_index = 100
	
	position = Vector2(0,700)
	
	msg_sprite = Sprite.new()
	msg_sprite.centered = true
	msg_sprite.position = Vector2(152,0)
	msg_sprite.texture = msg_image
	add_child(msg_sprite)
	
	msg_rtl = Label.new()
	add_child(msg_rtl)
	msg_rtl.rect_position = Vector2(30, -43)
	msg_rtl.align = Label.ALIGN_CENTER
	msg_rtl.valign = Label.ALIGN_CENTER
	msg_rtl.rect_scale = Vector2(text_scale,text_scale)
	msg_rtl.rect_size = rect_size
	msg_rtl.text = "---"
	msg_rtl.add_font_override("font", load(font))
	
	msg_step_timer = Timer.new()
	add_child(msg_step_timer)
	msg_step_timer.set_wait_time(msg_step_time)
	msg_step_timer.set_one_shot(false)
	msg_step_timer.connect("timeout", self, "msg_step")
	
	midstop_timer = Timer.new()
	add_child(midstop_timer)
	midstop_timer.set_wait_time(midstop_time)
	midstop_timer.set_one_shot(true)
	midstop_timer.connect("timeout", self, "switch_midstop")

func switch_midstop():
	speed_mod = speed_mod * -8
	pass

func run_msg(new_msg: String):
	msg_step_timer.stop()
	midstop_timer.stop()
	position = Vector2(0,700)
	scroll_speed = starting_scroll_speed
	speed_mod = starting_speed_mod
	print("start message: " + new_msg)
	if new_msg.length() > 15:
		print("shortend string")
		new_msg = "Oh no!"
	msg_rtl.text = new_msg
	msg_step_timer.start()
	midstop_timer.start()
	pass

func msg_step():
	translate(Vector2(0,-1)*scroll_speed)
	scroll_speed -= speed_mod
	if scroll_speed < 0:
		scroll_speed = 0
	if position.y <= -1250:
		msg_step_timer.stop()
		position = Vector2(0,800)
	pass
