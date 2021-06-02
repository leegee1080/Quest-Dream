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
	Tile_Enums.center_type_enum.rest: [0, 0, 0, 0, 1]
}
#generic room vars
var player
var type_enum
var room_type_hash #stores the stats about the room type from the room_type_dict
var theme_enum
var room_theme_frame #stores the frame number of the room theme
var room_screen_loc #the location the room will appear on the player's screen
var room_level
var is_saved_room
var timer_group = Node2D.new() #a place to hold timers
var leave_time = 1.0
var is_room_complete = false
var ani_sprite

#battle vars
var enemies = []
var original_enemies = []#this is the list of enemies that wree created at the start of the room
var turn_order = []
var turn_counter_max
var turn_counter_min
var turn_counter
var turn_order_list

#loot vars


func _ready():
	add_child(timer_group) #a place to hold timers
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(room_theme_frame)
	position = room_screen_loc
	generate_room()

func _init(new_type, new_theme, level, new_room_screen_loc, is_loaded_room: bool, passed_player_node):
	theme_enum = new_theme
	type_enum = new_type
	room_level = level
	room_type_hash = room_type_dict.get(new_type)
	room_theme_frame = room_theme_dict.get(new_theme)
	room_screen_loc = new_room_screen_loc
	is_saved_room = is_loaded_room
	player = passed_player_node

func process_room():
	#if rest room, restore health
	if type_enum == Tile_Enums.center_type_enum.battle:
		battle_room()
		return
	if type_enum == Tile_Enums.center_type_enum.treasure:
		treasure_room()
		return
	if type_enum == Tile_Enums.center_type_enum.rest:
		rest_room()
		return

func generate_room():
	add_child(ani_sprite)
	#create deco tiles
	process_room()
	return

func complete_room():
	GlobalVars.main_node_ref.generate_ui(GlobalVars.main_node_ref.room_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "room_back_btn", GlobalVars.main_node_ref.room_button_z_index)
	is_room_complete = true
	for obj in timer_group.get_children():
		obj.stop()
		obj.queue_free()
	print("room complete")

func leave_room():
	if is_room_complete == true:
		if room_type_hash[3] == 0:
			GlobalVars.main_node_ref.delete_centertile()
			GlobalVars.temp_loot_pool.clear()
			queue_free()
			return
		#this saves the room for later
		GlobalVars.main_node_ref.save_centertile()
		queue_free()

func rest_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.start()
	player.heal_player(10*room_level)#add health based on the level of the room
	print("heal")
	#ask player which skills to level up
	return

func find_turn_counter_maximums(player_speed):
	turn_counter_max = player_speed + 1
	turn_counter_min = player_speed
	for bad in enemies:
		if (bad.stat_dict.speed > turn_counter_max):
			turn_counter_max = bad.stat_dict.speed
		if (bad.stat_dict.speed < turn_counter_max):
			turn_counter_min = bad.stat_dict.speed
		pass
	return

#check for deaths func's
func check_player_death():
	if player.is_dead:
		complete_room()
		return true
	return false

func check_enemies_death():
	var all_enemies_dead = true
	for mob in enemies:
		if mob.is_dead == false:
			all_enemies_dead = false
	if all_enemies_dead:
		complete_room()
#	update_enemy_list()
	return

func create_turn_list():
	var turn_list = []
	var local_turn_counter = turn_counter_max + 1
	while local_turn_counter > turn_counter_min:
		local_turn_counter -= 1
		if local_turn_counter <= player.player_stat_dict.speed:
			turn_list.append(player)
			pass
		for mob in enemies:
			if local_turn_counter <= mob.stat_dict.speed:
				turn_list.append(mob)
				pass
		continue
	turn_order_list = turn_list
	return

func update_enemy_list():
	var temp_list = []
	for item in enemies:
		if item.is_dead == false:
			temp_list.append(item)
		pass
	enemies = temp_list
	return

func pass_battle_turn():
	var chosen_target = null
	if turn_order_list[turn_counter] == null:
		return
	if is_room_complete:
		return
	print("Starting turn: " + str(turn_counter))
	randomize()
	if turn_order_list[turn_counter] == player: #if its the player's turn choose random enemy
		chosen_target = enemies[int(rand_range(0,enemies.size()))]
	else:
		chosen_target = player #else if its enemy's turn target player
	turn_order_list[turn_counter].process_turn(chosen_target) #processes the turn of the chosen node
	check_player_death()
	check_enemies_death()
	turn_counter += 1
	print("turn passed")
	update_enemy_list()
	if(turn_counter > turn_order_list.size()-1):
		turn_counter = 0
	#if all enemies are dead:
	#	complete room and give loot
	return

func battle_room():
	print("battle")
	#generate enemies
	if is_saved_room == false:
		randomize()
		var rand_num_enemies = int(rand_range(1, room_level+3))
		for i in rand_num_enemies:
			randomize()
			var chosen_enemy_list = GlobalVars.stage_enemies_dict[int(rand_range(1,GlobalVars.stage_enemies_dict[room_level].size()))]
			var chosen_enemy_type = chosen_enemy_list[int(rand_range(0,chosen_enemy_list.size()))]
			var new_enemy = Enemy.new(chosen_enemy_type)
			enemies.append(new_enemy)
			GlobalVars.main_node_ref.add_child(new_enemy)
			var spawn_pos = Vector2(rand_range(GlobalVars.main_node_ref.content_room_screen_loc.x - 20, GlobalVars.main_node_ref.content_room_screen_loc.x + 20), rand_range(GlobalVars.main_node_ref.content_room_screen_loc.y - 20, GlobalVars.main_node_ref.content_room_screen_loc.y + 20))
			new_enemy.position = spawn_pos #place the baddies at the right area in the room
			new_enemy.z_index = GlobalVars.main_node_ref.get_child_count()-1 #place baddies on the top layer
	#set turn order
	turn_counter = 0
	find_turn_counter_maximums(player.player_stat_dict.speed)
	create_turn_list()
	original_enemies = enemies #update the static list of enemies to be deleted later
	#loop turn order until end
	var battle_turn_timer = Timer.new()
	battle_turn_timer.name = "Battleturn Timer"
	battle_turn_timer.set_wait_time(1.5)
	battle_turn_timer.set_one_shot(false)
	battle_turn_timer.connect("timeout", self, "pass_battle_turn")
	timer_group.add_child(battle_turn_timer)
	battle_turn_timer.add_to_group("timers")
	battle_turn_timer.start()
	return

func treasure_room():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.add_to_group("timers")
	leave_timer.start()
	print("treasure")
	return

