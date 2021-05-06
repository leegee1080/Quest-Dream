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
#generic room vars
var type_enum
var room_type_hash #stores the stats about the room type from the room_type_dict
var theme_enum
var room_theme_frame #stores the frame number of the room theme
var room_screen_loc #the location the room will appear on the player's screen
var room_level
var is_saved_room
var timer_group = Node2D.new() #a place to hold timers

#battle vars
var enemies = []
var turn_order = []
var xp_earned = 0
var loot_pile = []
var turn_counter_max
var turn_counter_min
var turn_counter

var leave_time = 1.0
var is_room_complete = false
var ani_sprite

func _ready():
	add_child(timer_group) #a place to hold timers
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(room_theme_frame)
	position = room_screen_loc
	generate_room()

func _init(new_type, new_theme, level, new_room_screen_loc, is_loaded_room: bool):
	theme_enum = new_theme
	type_enum = new_type
	room_level = level
	room_type_hash = room_type_dict.get(new_type)
	room_theme_frame = room_theme_dict.get(new_theme)
	room_screen_loc = new_room_screen_loc
	is_saved_room = is_loaded_room

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
	for obj in timer_group.get_children():
		obj.queue_free()
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
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	get_parent().player.heal_player(10*room_level)#add health based on the level of the room
	print("heal")
	return

func find_turn_counter_maximums(enemies_list, player_speed):
	turn_counter_max = player_speed + 1
	turn_counter_min = player_speed
	for bad in enemies_list:
		if (bad.stat_dict.speed > turn_counter_max):
			turn_counter_max = bad.stat_dict.speed
		if (bad.stat_dict.speed < turn_counter_max):
			turn_counter_min = bad.stat_dict.speed

#check for deaths func's
func check_player_death():
	if get_parent().player.is_dead:
		complete_room()
	return

func check_enemies_death():
	var all_enemies_dead = true
	for mob in enemies:
		if mob.is_dead == false:
			all_enemies_dead = false
	if all_enemies_dead:
		complete_room()
	return

func pass_battle_turn():
	turn_counter -= 1
	randomize()
	if turn_counter <= get_parent().player.player_stat_dict.speed:
		var player_target = enemies[int(rand_range(0,enemies.size()))]
		get_parent().player.process_turn(player_target)
	
	for mob in enemies:
		if turn_counter <= mob.stat_dict.speed:
			mob.process_turn(get_parent().player)
			check_player_death()
	
	check_enemies_death()
	print("turn passed")
	if(turn_counter < turn_counter_min):
		turn_counter = turn_counter_max
	#if all enemies are dead:
	#	complete room and give loot
	return

func battle_room():
	print("battle")
	#generate enemies
	randomize()
	if is_saved_room == false:
		var rand_num_enemies = int(rand_range(1, room_level+1))
		for i in rand_num_enemies:
			var new_enemy = Enemy.new(null, room_level)
			enemies.append(new_enemy)
			get_parent().add_child(new_enemy)
			var spawn_pos = Vector2(rand_range(get_parent().content_room_screen_loc.x - 20, get_parent().content_room_screen_loc.x + 20), rand_range(get_parent().content_room_screen_loc.y - 20, get_parent().content_room_screen_loc.y + 20))
			new_enemy.position = spawn_pos #place the baddies at the right area in the room
			new_enemy.z_index = get_parent().get_child_count()-1 #place baddies on the top layer
	#set turn order
	find_turn_counter_maximums(enemies, get_parent().player.player_stat_dict.speed)
	#loop turn order until end
	turn_counter = turn_counter_max #start the turn counter at the top
	var battle_turn_timer = Timer.new()
	battle_turn_timer.name = "Leave Timer"
	battle_turn_timer.set_wait_time(1)
	battle_turn_timer.set_one_shot(false)
	battle_turn_timer.connect("timeout", self, "pass_battle_turn")
	timer_group.add_child(battle_turn_timer)
	battle_turn_timer.start()
	return

func shop_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("shop")
	return

func treasure_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("treasure")
	return

func silly_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	print("silly complete")
	return
