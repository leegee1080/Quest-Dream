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

#[0base enemies to gen, 1base loot to gen, 2base number of shopkeep items, 3can return to room true1/false0, 4can rest true1/false0]
const room_type_dict = {
	Tile_Enums.center_type_enum.battle: [1, 1, 0, 0, 0],
	Tile_Enums.center_type_enum.treasure: [0, 1, 0, 1, 0],
	Tile_Enums.center_type_enum.shop: [0, 0, 1, 1, 0],
	Tile_Enums.center_type_enum.rest: [0, 0, 0, 0, 1],
	Tile_Enums.center_type_enum.silly: [0, 0, 0, 0, 0]
}

var type_enum
var room_type_hash #stores the stats about the room type from the room_type_dict
var theme_enum
var room_theme_frame #stores the frame number of the room theme
var room_screen_loc #the location the room will appear on the player's screen
var room_level

var leave_time = 1.0
var is_room_complete = false
var ani_sprite

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(room_theme_frame)
	position = room_screen_loc
	generate_room()

func _init(new_type, new_theme, level, new_room_screen_loc):
	theme_enum = new_theme
	type_enum = new_type
	room_level = level
	room_type_hash = room_type_dict.get(new_type)
	room_theme_frame = room_theme_dict.get(new_theme)
	room_screen_loc = new_room_screen_loc

func process_room():
	#if rest room, restore health
	if type_enum == Tile_Enums.center_type_enum.battle:
		battle_room()
		return
	if type_enum == Tile_Enums.center_type_enum.treasure:
		treasure_room()
		return
	if type_enum == Tile_Enums.center_type_enum.shop:
		shop_room()
		return
	if type_enum == Tile_Enums.center_type_enum.rest:
		rest_room()
		return
	if type_enum == Tile_Enums.center_type_enum.silly:
		silly_room()
		return

func generate_room():
	add_child(ani_sprite)
	#create deco tiles
	process_room()
	return

func complete_room():
	is_room_complete = true
	print("room complete")

func leave_room():
	if is_room_complete == true:
		if room_type_hash[3] == 0:
			get_parent().delete_centertile()
			queue_free()
			return
		#this saves the room for later
		get_parent().save_centertile()
		queue_free()

func rest_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	get_parent().player.heal_player(10*room_level)#add health based on the level of the room
	print("heal")
	return

func battle_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("battle")
	return

func shop_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("shop")
	return

func treasure_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("treasure")
	return

func silly_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("silly complete")
	return
