extends Node2D

class_name Stage

var player = Map_Player.new()
var chosen_level_theme = Tile_Enums.tile_themes_enum.castle
var is_fast_forwarded = false
var premade_tile_pool

var round_start_time = 5.0
var start_countdown = 4
var start_countdown_timer

var num_difficult_tiles = int(0.5 * GlobalVars.current_stage_number)
var num_end_tiles = 1 + int(GlobalVars.current_stage_number / 5)

var current_game_state
var previous_game_state
enum game_state{
	setup,
	run,
	pause,
	boss,
	lose,
	win
}

#ui vars
const main_button_z_index = 1
const main_button_loc_dict = {
	#fill with the locations to instance the button objects
	"pause": [Vector2(201,377), 4, 5],
	"action": [Vector2(201,307), 20, 21]
}
const menu_button_z_index = 15
const menu_button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(49,301), 0, 1],
	"quit": [Vector2(119,301), 6, 7],
	"fastforward": [Vector2(189,301), 2, 3]
}
const boss_menu_button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(49,301), 0, 1],
	"quit": [Vector2(119,301), 6, 7]
}

var pause_menu_sprite = load("res://assets/visuals/pause_menu_bg.png")
var pause_menu
const pause_menu_loc = Vector2(152,273)

##play area vars
var ingame_tilegroup_Node = Node2D.new()
var can_player_place_tiles
# [[xmin, xmax],[ymin, ymax], name of coord, middle vector of coord]
var clickable_coords_list = []
var clickable_area_was_clicked = false
var potential_terminal_locations = []
var start_tile
var end_tile
var tile_dict = {} #this is a dict more readable collection of tiles (string: tileobject)
const starting_playarea_coord = [32,32] #the center x y of the starting top left corner of the play area
const tile_size = 48
var rows_total = 5
var col_total = 5
var max_starting_playarea = [starting_playarea_coord,[starting_playarea_coord[0]+((col_total)* tile_size), starting_playarea_coord[1]+((rows_total) *tile_size)]]

#room screen vars
var room_screen
const room_screen_loc = Vector2(152,152)
var player_room_screen_loc = Vector2(room_screen_loc[0]-40,room_screen_loc[1])
var player_last_loc
var content_room_screen_loc = Vector2(room_screen_loc[0]+20,room_screen_loc[1])

#gamestate timer
const gamestate_time = 2
var gamestate_timer

##queue area vars
const queue_length = 5
var tile_queue = []
const queue_loc_dict = {
	"0":Vector2(56,332),
	"1":Vector2(56,412),
	"2":Vector2(56,492),
	"3":Vector2(136,492),
	"4":Vector2(216,492)
}

func _init(theme):
	chosen_level_theme = theme
	pass

func _ready():
	if get_parent().is_boss_stage:
		get_parent().msg_node.run_msg("Boss Stage!")
	else:
		get_parent().msg_node.run_msg("Stage " + str(GlobalVars.current_stage_number))
	current_game_state = game_state.setup
	var bg_sprite = Sprite.new()
	bg_sprite.centered = false
	bg_sprite.texture = load("res://assets/visuals/bg.png")
	add_child(bg_sprite)
	add_child(ingame_tilegroup_Node)
	ingame_tilegroup_Node.name = "Ingame Tilegroup"
	
	#setup global refs
	GlobalVars.main_node_ref = self
	GlobalVars.player_node_ref = player
	if GlobalVars.player_consumable_amount == 0:
		GlobalVars.player_consumable_amount = GlobalVars.player_type_class_storage.starting_consumable_amt
		pass
	#create UI
	UI_Vars.generate_button(main_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "main", main_button_z_index, self)
	
	#music
	if GlobalVars.audio_player.audio_streams[GlobalVars.audio_player.song_themes[GlobalVars.current_theme][0]].is_playing() == false:
		GlobalVars.audio_player.stop_all_music()
		GlobalVars.audio_player.play(GlobalVars.audio_player.song_themes[GlobalVars.current_theme][0])
	
	#setup start timer and player character
	can_player_place_tiles = true
	var start_timer = Timer.new()
	start_timer.name = "Start Timer"
	add_child(start_timer)
	start_timer.add_to_group("timers")
	start_timer.set_wait_time(round_start_time)
	start_timer.set_one_shot(true)
	start_timer.connect("timeout", self, "start_round")
	start_timer.start()
	
	start_countdown_timer = Timer.new()
	start_countdown_timer.name = "Countdown Timer"
	add_child(start_countdown_timer)
	start_countdown_timer.add_to_group("timers")
	start_countdown_timer.set_wait_time(1.5)
	start_countdown_timer.set_one_shot(true)
	start_countdown_timer.connect("timeout", self, "round_start_countdown")
	start_countdown_timer.start()
	
	gamestate_timer = Timer.new()
	gamestate_timer.name = "Gamestate Timer"
	add_child(gamestate_timer)
	gamestate_timer.add_to_group("timers")
	gamestate_timer.set_wait_time(gamestate_time)
	gamestate_timer.set_one_shot(true)
	gamestate_timer.connect("timeout", self, "comunicate_winstate_gamemaster")
	#setup the clickable play area and starting tiles
	setup_coord_array()
	setup_tile_dict()
	generate_premade_center_tile_pool()
	place_starting_tiles()
#	print(premade_tile_pool)
	#setup the player's character
	add_child(player)
	player.playarea = max_starting_playarea
	if get_parent().is_boss_stage:
		player.exit_tile_pos = null
	else:
		player.exit_tile_pos = end_tile.position
	player.name = "Player"
	player.position = start_tile.position
	#generate the heads-up for collectables
	var temp_player_consumable = player.type_class.consumable_class.new()
	var temp_ui_player_info = UI_Player_Info.new(temp_player_consumable.item_frame)
	add_child(temp_ui_player_info)

func ui_func(new_name, _btn_node_ref): #checks which button is pressed
	if UiVars.is_trans:
		return
	if new_name == "back":
		ui_back()
		return
#	if new_name == "pause":
#		ui_pause()
#		return
	if new_name == "pause":
		ui_menu()
		return
	if new_name == "quit":
		ui_quit()
		return
	if new_name == "fastforward":
		ui_fastforward()
		return
	if new_name == "action":
		if is_fast_forwarded:
			return
		ui_action()
		return

func ui_quit():
	GlobalVars.audio_player.stop_all_music()
	get_parent().exit_to_menu()
	pass

func ui_fastforward():
	GlobalVars.audio_player.play("fastforward")
	is_fast_forwarded = true
#	var new_speed = 0.0001
	for node in get_tree().get_nodes_in_group("fast_forward_grp"):
		if node == null:
			continue
		node.fast_forward()
#	player.walk_timer.set_wait_time(new_speed)
	print("fast forwarded")
	pass

func ui_back():
	pause_menu.queue_free()
	UI_Vars.hide_buttons("pause_menu")
	ui_unpause()
	UI_Vars.generate_button(main_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "main", main_button_z_index, self)

func ui_unpause():
	GlobalVars.audio_player.play("pause")
	var timers = get_tree().get_nodes_in_group("timers")
	current_game_state = previous_game_state
	for timer in timers:
		timer.paused = false
	current_game_state = game_state.run
	can_player_place_tiles = true
	print("unpause game")

func ui_pause():
	GlobalVars.audio_player.play("unpause")
	var timers = get_tree().get_nodes_in_group("timers")
	previous_game_state = current_game_state
	for timer in timers:
		timer.paused = true
	current_game_state = game_state.pause
	can_player_place_tiles = false
	print("pause game")

func ui_menu():
	pause_menu = Sprite.new()
	pause_menu.position = pause_menu_loc
	pause_menu.texture = pause_menu_sprite
	pause_menu.z_index = 15
	add_child(pause_menu)
	if get_parent().is_boss_stage:
		UI_Vars.generate_button(boss_menu_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "pause_menu", menu_button_z_index, self)
	else:
		UI_Vars.generate_button(menu_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "pause_menu", menu_button_z_index, self)
	ui_pause()
	UI_Vars.hide_buttons("main")

func ui_action():
	if GlobalVars.player_consumable_amount >= (GlobalVars.player_type_class_storage.action_cost + 1):
		GlobalVars.player_node_ref.map_action()

func generate_premade_center_tile_pool():
	var pool_array = []
	randomize()
	GlobalVars.premade_center_chance_array.shuffle()
	for i in range(0, GlobalVars.current_stage_number, 1):
		pool_array.append(GlobalVars.premade_center_chance_array[i])
	premade_tile_pool = pool_array
	pass

func round_start_countdown():
#	get_parent().msg_node.run_msg("Go!")
#	if start_countdown <= 0:
#		get_parent().msg_node.run_msg("Go!")
#		start_countdown_timer.stop()
#	else:
#		get_parent().msg_node.run_msg(str(start_countdown))
#	start_countdown -= 1
	pass

func start_round(): #just for the first time start, can add more here if needed
	current_game_state = game_state.run
	player.walk_toggle()
	if get_parent().is_boss_stage:
		randomize()
		Boss_Enums.boss_theme_dict[GlobalVars.current_theme].shuffle()
		GlobalVars.boss_node_ref = Boss_Enums.boss_theme_dict[GlobalVars.current_theme][0].new()
		add_child(GlobalVars.boss_node_ref)
	pass

func lose_round():
	GlobalVars.audio_player.play("lose")
	get_parent().msg_node.run_msg("You Died!")
	if current_game_state == game_state.run:
		player.walk_toggle()
	print("Round Lost")
	current_game_state = game_state.lose
	gamestate_timer.start()
	pass

func win_round():
	GlobalVars.audio_player.play("win")
	if get_parent().is_boss_stage:
		get_parent().msg_node.run_msg("Boss Killed!")
		get_parent().msg_node_subtext.run_msg("money: Banked!")
	else:
		get_parent().msg_node.run_msg("Round Complete!")
		get_parent().msg_node_subtext.run_msg("Keep Going!")
	if current_game_state == game_state.run:
		player.walk_toggle()
	GlobalVars.player_node_ref.ani_dict.happy.play_animation()
	print("Round Win")
	current_game_state = game_state.win
	gamestate_timer.start()
	pass

func comunicate_winstate_gamemaster():
	if current_game_state == game_state.win:
		get_parent().win_stage()
		return
	if current_game_state == game_state.lose:
		get_parent().lose_stage()
		return
	pass

func _input(event):
	if event is InputEventMouseButton: #when the user clicks
#		if UiVars.clicked == true:
#			return
		if clickable_area_was_clicked == true:
			clickable_area_was_clicked = false
			return
		if can_player_place_tiles and (current_game_state == game_state.run or current_game_state == game_state.setup):
			clickable_area_was_clicked = true
			for loc in clickable_coords_list:
				var x_test = loc[0]
				var y_test = loc[1]
				if event.position[0] >= x_test[0] and event.position[0] < x_test[1] and event.position[1] >= y_test[0] and event.position[1] < y_test[1]:
					if tile_dict.get(loc[2]) != null and tile_dict.get(loc[2]).is_locked == false:
	#					print(tile_dict.get(loc[2]).name)
						tile_dict.get(loc[2]).delete_tile()
						tile_dict[loc[2]] = null
						return
					elif tile_dict.get(loc[2]) == null and tile_queue.size()>0:
						#assign the new tile node to the correct dictionary entry
						GlobalVars.audio_player.play("placetile")
						tile_dict[loc[2]] = tile_queue[0]
						tile_dict[loc[2]].place_tile(loc[3])
						tile_dict[loc[2]].name = loc[2]
						tile_dict[loc[2]].tile_loc_clickable_area = loc[4]
						slide_queue()
						return

func delete_centertile():
	var current_tile = player.current_tile
	current_tile.center_subtile.queue_free()
	for enemy in room_screen.original_enemies:
		enemy.queue_free()
	#play close room animation
	return

func slide_queue():
	var index = 1
	var temp_array = []
	while index < queue_length:
		temp_array.append(tile_queue[index])
		index += 1
	tile_queue = temp_array
	index = 0
	for tile in tile_queue:
		tile.name = "Queued Tile: " + str(index)
		tile.position.x = queue_loc_dict.get(str(index)).x
		tile.position.y = queue_loc_dict.get(str(index)).y
		index += 1
	var new_tile = generate_random_tile()
	tile_queue.append(new_tile)
	ingame_tilegroup_Node.add_child(new_tile)
	new_tile.name = str(queue_length-1)
	new_tile.position.x = queue_loc_dict.get(str(queue_length-1)).x
	new_tile.position.y = queue_loc_dict.get(str(queue_length-1)).y
	return

func generate_random_tile():
	var tile
	randomize()
	GlobalVars.tile_path_type_chance_array.shuffle()
	var chosen_tile_type = GlobalVars.tile_path_type_chance_array[0]
	GlobalVars.tile_center_chance_array.shuffle()
	var chosen_tile_center = GlobalVars.tile_center_chance_array[0]
	#direction, theme, center, deco amount, chosen sprite(-1 for rand)
	tile = Tile.new(chosen_tile_type, chosen_level_theme, chosen_tile_center, 1, -1)
	return tile

func setup_tile_dict():
	var col = col_total
	var rows = rows_total
	while col > 0:
		rows = rows_total
		while rows > 0:
			tile_dict[str(col)+","+str(rows)] = null
			rows -= 1
		col -= 1
#	print(tile_dict)
	return

func setup_coord_array():
	var col = col_total
	var row = rows_total
	var current_x = starting_playarea_coord[0]
	var current_y = starting_playarea_coord[1]
	while col > 0:
		row = rows_total
		current_y = starting_playarea_coord[1]
		while row > 0:
			var coord_name = str(col)+","+str(row)
			var coord_name_vector = Vector2(col, row)
			#add a terminal loc at the start and end of a row and col
			if coord_name_vector != Vector2(col_total, rows_total) and coord_name_vector != Vector2(1, 1) and coord_name_vector != Vector2(1, rows_total) and coord_name_vector != Vector2(col_total, 1):
				if row == 1:
					potential_terminal_locations.append([Vector2(current_x+24, current_y+56),coord_name_vector])
				if col == 1:
					potential_terminal_locations.append([Vector2(current_x+56, current_y+24),coord_name_vector])
				if row == rows_total:
					potential_terminal_locations.append([Vector2(current_x+24, current_y-8),coord_name_vector])
				if col == col_total:
					potential_terminal_locations.append([Vector2(current_x-8, current_y+24),coord_name_vector])
			#add an array of usuable coords for placing tiles in play area
			clickable_coords_list.append([[current_x,current_x+48],[current_y,current_y+48],coord_name, Vector2(current_x+24, current_y+24), Vector2(col,row)])
			current_y += 48
			row -= 1
		current_x += 48
		col -= 1
	return

func pick_premade_tile():
	var tile
	randomize()
	premade_tile_pool.shuffle()
	tile = premade_tile_pool[0]
	return tile

func place_starting_tiles():
	var tile
	var picked_coord
	randomize()
	#work on start tile
	var start_tile_index = int(rand_range(0,potential_terminal_locations.size())) #so that the entry can be removed later insuring the end and start are not on the same tile
	var start_tile_sprite_index = 0
	var start_tile_name = "null"
	picked_coord = potential_terminal_locations[start_tile_index]
	if picked_coord[1].y == 1:
		start_tile_sprite_index = 2
		player.direction = Vector2(0,-1)
		start_tile_name = "Start TileH"
	elif picked_coord[1].y == rows_total:
		start_tile_sprite_index = 3
		player.direction = Vector2(0,1)
		start_tile_name = "Start TileH"
	elif picked_coord[1].x == 1:
		start_tile_sprite_index = 0
		player.direction = Vector2(-1,0)
		start_tile_name = "Start TileV"
	elif picked_coord[1].x == col_total:
		start_tile_sprite_index = 1
		player.direction = Vector2(1,0)
		start_tile_name = "Start TileV"
	start_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, 0, start_tile_sprite_index)
	start_tile.name = start_tile_name
	start_tile.is_terminal_tile = true
	add_child(start_tile)
	start_tile.place_tile(picked_coord[0])
	potential_terminal_locations.remove(start_tile_index)
	#work on end tile
	while num_end_tiles > 0 and get_parent().is_boss_stage == false:
		var end_tile_sprite_index = 0
		var end_tile_index = int(rand_range(0,potential_terminal_locations.size()))
		picked_coord = potential_terminal_locations[end_tile_index]
		if picked_coord in potential_terminal_locations:
			if picked_coord[1].y == 1:
				end_tile_sprite_index = 3
			elif picked_coord[1].y == rows_total:
				end_tile_sprite_index = 2
			elif picked_coord[1].x == 1:
				end_tile_sprite_index = 1
			elif picked_coord[1].x == col_total:
				end_tile_sprite_index = 0
			end_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, 0, end_tile_sprite_index)
			end_tile.name = "End Tile"
			end_tile.is_terminal_tile = true
			add_child(end_tile)
			end_tile.place_tile(picked_coord[0])
			num_end_tiles -=1
			potential_terminal_locations.remove(end_tile_index)
	#place preplaced tiles
	if num_difficult_tiles > 1 and get_parent().is_boss_stage == false:
		while num_difficult_tiles > 0:
			picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
			if start_tile.position.distance_to(picked_coord[3]) > 48 and (num_end_tiles == 0 or end_tile.position.distance_to(picked_coord[3]) > 48):
				randomize()
				GlobalVars.tile_path_type_chance_array.shuffle()
				tile = Tile.new(GlobalVars.tile_path_type_chance_array[0], chosen_level_theme, pick_premade_tile(), 0, -1)
				tile.name = "Premade Tile: " + str(num_difficult_tiles)
				tile_dict[picked_coord[2]] = tile
				ingame_tilegroup_Node.add_child(tile)
				tile.place_tile(picked_coord[3])
				tile.lock_tile()
			num_difficult_tiles -= 1

	#create the starting queue
	var queue = 0
	while queue < queue_length:
		tile = generate_random_tile()
		ingame_tilegroup_Node.add_child(tile)
		tile_queue.append(tile)
		tile.name = "Queued Tile: " + str(queue)
		tile.position.x = queue_loc_dict.get(str(queue)).x
		tile.position.y = queue_loc_dict.get(str(queue)).y
		queue += 1
	return
