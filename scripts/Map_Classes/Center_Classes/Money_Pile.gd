extends Node2D

class_name Money_Pile

var sound

var ani_sprite
var item_frame = 61
const can_pick_up = true
var changes_direction = false

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)

func pick_up():
	#play sound
	#play animation
	print("money")
	GlobalVars.player_node_ref.ani_dict.happy.play_animation()
	GlobalVars.money_gained_this_run += 5
	get_tree().call_group("UI_Player_Info", "update_money")
	finish_pickup_animation()
	return changes_direction

func finish_pickup_animation():
	get_parent().center_object_enum = 0
	queue_free()
