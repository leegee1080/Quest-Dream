extends Node2D

class_name Stage

var cheats_on = true

var difficulty = 1
var stage_level = 1
var player = Map_Player.new(Player_Enums.player_types_enum.assassin)
var chosen_level_theme = Tile_Enums.tile_themes_enum.castle

var round_start_time = 5.0
var num_impass_tiles = 2

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
	"menu": [Vector2(191,307), 4, 5]
}
const menu_button_z_index = 15
const menu_button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(40,300), 0, 1],
	"quit": [Vector2(110,300), 6, 7],
	"fastforward": [Vector2(180,300), 2, 3]
}
const room_button_z_index = 5
const room_button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(111,207), 0, 1]
}
var pause_menu_sprite = load("res://assets/visuals/menu_bg.png")
var pause_menu
const pause_menu_loc = Vector2(150,270)

##play area vars
var can_player_place_tiles
# [[xmin, xmax],[ymin, ymax], name of coord, middle vector of coord]
var clickable_coords_list = []
var potential_terminal_locations = []
var start_tile
var end_tile
var tile_dict = {} #this is a dict more readable collection of tiles (string: tileobject)
const starting_playarea_coord = [32,32] #the center x y of the starting top corner of the play area
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

func _ready():
	current_game_state = game_state.setup
	#setup global refs
	GlobalVars.main_node_ref = self
	GlobalVars.player_node_ref = player
	GlobalVars.player_consumable_amount = player.type_class.starting_consumable_amt
	#create UI
	generate_ui(main_button_loc_dict, "res://assets/visuals/button_frames.tres", Vector2(66,137), "main", main_button_z_index)
	
	#setup dict for enemies
	generate_enemies_dict()
	
	#setup the chances to pull a certain tile for the queue
	generate_tile_chance_arrays(Tile_Enums.tile_path_chances, GlobalVars.tile_path_type_chance_array)
	generate_tile_chance_arrays(Tile_Enums.tile_center_chances, GlobalVars.tile_center_chance_array)
	
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
	#setup the clickable play area and starting tiles
	setup_coord_array()
	setup_tile_dict()
	place_starting_tiles()
	#setup the player's character
	add_child(player)
	player.playarea = max_starting_playarea
	player.exit_tile_pos = end_tile.position
	player.name = "Player"
	player.position = start_tile.position
	
	#generate the heads-up for collectables
	var temp_player_consumable = player.type_class.consumable_class.new()
	var temp_ui_player_info = UI_Player_Info.new(temp_player_consumable.item_frame, player.type_class.attack_sprite_frame, player.type_class.dodge_sprite_frame)
	add_child(temp_ui_player_info)

func generate_ui(button_loc_dict, sprite_frames_file_loc, button_size, button_container_name, new_z_index):
	var temp_button_list = []
	for btn in button_loc_dict:
		var temp_btn = Btn.new(button_loc_dict[btn][0], sprite_frames_file_loc, button_loc_dict[btn][1], button_loc_dict[btn][2], button_size)
		temp_btn.local_name = btn
#		temp_btn.name = btn
		temp_btn.connect("ui_sig", self, "ui_func")
		temp_button_list.append(temp_btn)
		temp_btn.z_index = new_z_index
		add_child(temp_btn)
	UiVars.buttons_dict[button_container_name] = temp_button_list
	pass

func ui_func(new_name, btn_node_ref): #checks which button is pressed
	if new_name == "back":
		ui_back(btn_node_ref)
		return
	if new_name == "pause":
		ui_pause()
		return
	if new_name == "menu":
		ui_menu()
		return
	if new_name == "quit":
		ui_quit()
		return
	if new_name == "fastforward":
		ui_fastforward()
		return

func ui_quit():
	get_tree().quit()
	pass

func ui_fastforward():
	var new_speed = 0.0001
	player.walk_timer.set_wait_time(new_speed)
	print("fast forwarded")
	pass

func ui_back(btn_node_ref):
	if current_game_state == game_state.pause:
		pause_menu.queue_free()
		for btn_list in UiVars.buttons_dict["pause_menu"]:
			if btn_list != null:
				btn_list.queue_free()
		ui_pause()
		return
	if current_game_state == game_state.boss:
		if room_screen.is_room_complete == true:
			btn_node_ref.queue_free()
			win_round()
		return

func ui_pause():
	var timers = get_tree().get_nodes_in_group("timers")
	if current_game_state == game_state.pause:
		current_game_state = previous_game_state
		for timer in timers:
			timer.paused = false
		can_player_place_tiles = true
		print("unpause game")
		return
	previous_game_state = current_game_state
	for timer in timers:
		timer.paused = true
	current_game_state = game_state.pause
	can_player_place_tiles = false
	print("pause game")

func ui_menu():
	if current_game_state == game_state.pause:
		return
	pause_menu = Sprite.new()
	pause_menu.position = pause_menu_loc
	pause_menu.texture = pause_menu_sprite
	pause_menu.z_index = 15
	add_child(pause_menu)
	generate_ui(menu_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "pause_menu", menu_button_z_index)
	ui_pause()

func generate_enemies_dict():
	for test in Enemy_Enums.enemy_types_dict:
		var test_enemy = Enemy_Enums.enemy_types_dict[test].new()
		if test_enemy.is_final_boss:
			GlobalVars.stage_enemies_dict[test_enemy.theme][1].append(Enemy_Enums.enemy_types_dict[test])
		else:
			GlobalVars.stage_enemies_dict[test_enemy.theme][0].append(Enemy_Enums.enemy_types_dict[test])
		print(test_enemy.string_name)
	print(GlobalVars.stage_enemies_dict[Tile_Enums.tile_themes_enum.forest])
	print(GlobalVars.stage_enemies_dict[Tile_Enums.tile_themes_enum.mountain])
	print(GlobalVars.stage_enemies_dict[Tile_Enums.tile_themes_enum.swamp])
	print(GlobalVars.stage_enemies_dict[Tile_Enums.tile_themes_enum.grave])
	print(GlobalVars.stage_enemies_dict[Tile_Enums.tile_themes_enum.castle])
	print("stage enemies dict")

func generate_tile_chance_arrays(array_to_check, chance_array_to_build):
	for test in array_to_check:
		if test[0] == 0:
			continue
		if test[0] == 1:
			chance_array_to_build.append(test[1])
			continue
		for _num in range(0, test[0]):
			chance_array_to_build.append(test[1])
			continue

func start_round(): #just for the first time start, can add more here if needed
	current_game_state = game_state.run
	player.walk_toggle()
	return

func lose_round():
	if current_game_state == game_state.run:
		player.walk_toggle()
	print("Round Lost")
	current_game_state = game_state.lose
	return

func win_round():
	if current_game_state == game_state.run:
		player.walk_toggle()
	print("Round Win")
	current_game_state = game_state.win
	return

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if cheats_on: #this is a cheat for opening the boss room instantly
				if event.scancode == KEY_SPACE and current_game_state != game_state.boss and current_game_state == game_state.run:
					open_boss_room()
					return
	if event is InputEventMouseButton: #when the user clicks
		if UiVars.clicked == true:
			return
		if can_player_place_tiles and (current_game_state == game_state.run or current_game_state == game_state.setup):
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
						tile_dict[loc[2]] = tile_queue[0]
						tile_dict[loc[2]].place_tile(loc[3])
						tile_dict[loc[2]].name = loc[2]
						slide_queue()
						return

func open_boss_room():
	player.walk_toggle()
	can_player_place_tiles = false
	room_screen = Room.new(Tile_Enums.center_type_enum.boss, chosen_level_theme, stage_level, room_screen_loc)
	room_screen.name = "boss battle"
	add_child(room_screen)
	current_game_state = game_state.boss
#play animation for opening room.
#add deco using deco tiles based on room theme
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
		tile.name = str(index)
		tile.position.x = queue_loc_dict.get(str(index)).x
		tile.position.y = queue_loc_dict.get(str(index)).y
		index += 1
	var new_tile = generate_random_tile()
	tile_queue.append(new_tile)
	$InGameTileGroup.add_child(new_tile)
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
			clickable_coords_list.append([[current_x,current_x+48],[current_y,current_y+48],coord_name, Vector2(current_x+24, current_y+24)])
			current_y += 48
			row -= 1
		current_x += 48
		col -= 1
#	print(clickable_coords_list)
#	print(potential_terminal_locations)
#	print(player_tile_dict)
	return

func place_starting_tiles():
	var tile
	var picked_coord
	randomize()
	#work on start tile
	var start_tile_index = int(rand_range(0,potential_terminal_locations.size())) #so that the entry can be removed later insuring the end and start are not on the same tile
	var start_tile_sprite_index = 0
	picked_coord = potential_terminal_locations[start_tile_index]
	if picked_coord[1].y == 1:
		start_tile_sprite_index = 2
		player.direction = Vector2(0,-1)
	elif picked_coord[1].y == rows_total:
		start_tile_sprite_index = 3
		player.direction = Vector2(0,1)
	elif picked_coord[1].x == 1:
		start_tile_sprite_index = 0
		player.direction = Vector2(-1,0)
	elif picked_coord[1].x == col_total:
		start_tile_sprite_index = 1
		player.direction = Vector2(1,0)
	start_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, 0, start_tile_sprite_index)
	start_tile.name = "Start Tile"
	add_child(start_tile)
	start_tile.place_tile(picked_coord[0])
	potential_terminal_locations.remove(start_tile_index)
	#work on end tile
	var end_tile_sprite_index = 0
	picked_coord = potential_terminal_locations[int(rand_range(0,potential_terminal_locations.size()))]
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
	add_child(end_tile)
	end_tile.place_tile(picked_coord[0])
	#place preplaced tiles
	if num_impass_tiles > 0:
		while num_impass_tiles > 0:
			picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
			if start_tile.position.distance_to(picked_coord[3]) > 48 and end_tile.position.distance_to(picked_coord[3]) > 48:
				tile = Tile.new(Tile_Enums.tile_directions_enum.impass, chosen_level_theme, Tile_Enums.center_type_enum.none, 0, -1)
				tile.name = "Impass Tile " + str(num_impass_tiles)
				tile_dict[picked_coord[2]] = tile
				$InGameTileGroup.add_child(tile)
				tile.place_tile(picked_coord[3])
				tile.lock_tile()
				tile.is_impass_tile = true
			num_impass_tiles -= 1

	#create the starting queue
	var queue = 0
	while queue < queue_length:
		tile = generate_random_tile()
		$InGameTileGroup.add_child(tile)
		tile_queue.append(tile)
		tile.name = str(queue)
		tile.position.x = queue_loc_dict.get(str(queue)).x
		tile.position.y = queue_loc_dict.get(str(queue)).y
		queue += 1
	return
