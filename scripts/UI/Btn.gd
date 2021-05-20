extends Node2D

class_name Btn

signal ui_sig(name)

#var clicked = false
var clickable = true
var clickable_area_max

var sprite_frames
var neutral_frame
var down_frame

var ani_sprite

func _init(new_loc: Vector2,  new_sprite_frames : String, new_neutral_frame: int, new_down_frame: int, new_size: Vector2):
	position = new_loc
	sprite_frames = new_sprite_frames
	neutral_frame = new_neutral_frame
	down_frame = new_down_frame
	clickable_area_max = Vector2(position.x + new_size.x, position.y + new_size.y)
	return

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load(sprite_frames))
	ani_sprite.set_frame(neutral_frame)
	ani_sprite.set_centered(false)
	add_child(ani_sprite)
	return

func _input(event):
	if clickable:
		if event is InputEventMouseButton:
			if UiVars.clicked == true and event.position[0] >= position.x and event.position[0] < clickable_area_max.x and event.position[1] >= position.y and event.position[1] < clickable_area_max.y:
				ani_sprite.set_frame(neutral_frame)
				click_btn()
				return
			if event.position[0] >= position.x and event.position[0] < clickable_area_max.x and event.position[1] >= position.y and event.position[1] < clickable_area_max.y:
				ani_sprite.set_frame(down_frame)
				return

func click_btn():
	emit_signal("ui_sig", name)
	return
