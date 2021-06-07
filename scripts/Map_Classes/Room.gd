extends Node2D

class_name Room

#this for the sprite frame
const room_theme_dict = {
	Tile_Enums.tile_themes_enum.castle: 0,
	Tile_Enums.tile_themes_enum.forest: 1,
	Tile_Enums.tile_themes_enum.grave: 2,
	Tile_Enums.tile_themes_enum.mountain: 3,
	Tile_Enums.tile_themes_enum.swamp: 4
}

#generic room vars
var type_enum
var theme_enum
var room_theme_frame #stores the frame number of the room theme
var room_screen_loc #the location the room will appear on the player's screen
var room_level
var timer_group = Node2D.new() #a place to hold timers
var leave_time = 1.0
var is_room_complete = false
var ani_sprite
var room_class

func _ready():
	add_child(timer_group) #a place to hold timers
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(room_theme_frame)
	position = room_screen_loc
	print("battle")
	room_class =  Boss_Room.new()
	add_child(room_class)

func _init(new_type, new_theme, level, new_room_screen_loc):
	theme_enum = new_theme
	type_enum = new_type
	room_level = level
	room_theme_frame = room_theme_dict.get(new_theme)
	room_screen_loc = new_room_screen_loc

func complete_room():
	GlobalVars.main_node_ref.generate_ui(GlobalVars.main_node_ref.room_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "room_back_btn", GlobalVars.main_node_ref.room_button_z_index)
	is_room_complete = true
	for obj in timer_group.get_children():
		obj.stop()
		obj.queue_free()
	print("room complete")

func leave_room():
	if is_room_complete == true:
		GlobalVars.main_node_ref.delete_centertile()
		queue_free()

func boss_battle_room():
	print("battle")
	room_class =  Boss_Room.new()
	add_child(room_class)