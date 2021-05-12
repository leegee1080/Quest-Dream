extends Node2D

class_name Main_Game

var clicked #this var is used for all clicking

var difficulty = 1
var stage_level = 1
var player = Player.new(Player.player_types_enum.assassin, 0, difficulty, {})
#var test_enemy = Enemy.new(null, difficulty)
var chosen_level_theme = Tile_Enums.tile_themes_enum.castle

var round_start_time = 5.0
var gen_boss_tile = true
var num_impass_tiles = 2

var current_game_state
var previous_game_state
enum game_state{
	run,
	pause,
	room,
	lose,
	win
}

#ui vars
const button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(111,307), 2, 3],
	"menu": [Vector2(191,307), 4, 5]
}

##play area vars
var can_player_place_tiles
# [[xmin, xmax],[ymin, ymax], name of coord, middle vector of coord]
export(Array) var clickable_coords_list = []
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
var stage_enemies_dict = { #this dict is filled at start of the main class, there is a list of all possible enemies per level of this theme
	0 : [],#this is the index of the boss enemies
	1 : [],
	2 : [],
	3 : [],
	4 : []
}

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
	#create UI
	generate_ui()
	
	#setup dict for enemies
	generate_enemies_dict()
	
	#setup start timer and player character
	can_player_place_tiles = true
	var start_timer = Timer.new()
	start_timer.name = "Start Timer"
	add_child(start_timer)
	start_timer.set_wait_time(round_start_time)
	start_timer.set_one_shot(true)
	start_timer.connect("timeout", self, "start_round")
	start_timer.start()
	setup_coord_array()
	setup_tile_dict()
	place_starting_tiles()
	add_child(player)
	player.playarea = max_starting_playarea
	player.exit_tile_pos = end_tile.position
	player.name = player.type_class.name
	player.position = start_tile.position
#	add_child(test_enemy)
#	test_enemy.name = test_enemy.type_class.name
#	test_enemy.position.x = 10
#	test_enemy.position.y = 200

func generate_ui():
	for btn in button_loc_dict:
		var temp_btn = Btn.new(button_loc_dict[btn][0], "res://assets/visuals/button_frames.tres", button_loc_dict[btn][1], button_loc_dict[btn][2], Vector2(66,137))
		temp_btn.name = btn
		add_child(temp_btn)
		temp_btn.connect("ui_sig", self, "iu_func")
	return

func iu_func(new_name): #checks which button is pressed
	if new_name == "back":
		ui_back()
		return
	if new_name == "pause":
		ui_pause()
		return
	if new_name == "menu":
		ui_menu()
		return

func ui_back():
	if current_game_state == game_state.room:
		if room_screen.is_room_complete == true:
			current_game_state = game_state.run
			room_screen.leave_room()
		pass
	return

func ui_pause():
	if current_game_state == game_state.pause:
		current_game_state = previous_game_state
		print("unpause game")
		return
	previous_game_state = current_game_state
	current_game_state = game_state.pause
	print("pause game")

func ui_menu():
	current_game_state = game_state.pause
	print("pop up menu")
	return

func generate_enemies_dict():
	for test in Enemy_Enums.enemy_types_dict:
		var test_enemy = Enemy_Enums.enemy_types_dict[test].new()
		for theme in test_enemy.theme_list:
			if theme == chosen_level_theme:
				stage_enemies_dict[test_enemy.difficulty].append(test)
	return

func start_round(): #just for the first time start, can add more here if needed
	player.walk_toggle()
	current_game_state = game_state.run
	return

func _input(event): #when the user clicks
	if event is InputEventMouseButton:
		if clicked == true:
			clicked = false
			return
		clicked = true
		if can_player_place_tiles:
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

func open_room(current_tile):
	can_player_place_tiles = false
	player_last_loc = player.position #grab pos to later return the player to last tile
	player.z_index = get_child_count()-1 #make sure the player sprite is on top
	var center_subtile = current_tile.center_subtile
	var saved_room = current_tile.saved_center_room
	print(
	"|level:" + str(center_subtile.subtile_level) + 
	"|type:" + Tile_Enums.center_type_enum.keys()[center_subtile.subtile_type_enum] +
	"|theme:" + Tile_Enums.tile_themes_enum.keys()[center_subtile.subtile_theme_enum]
	)
	var type = center_subtile.subtile_type_enum
	var theme = center_subtile.subtile_theme_enum
	var level = center_subtile.subtile_level
	room_screen = Room.new(type, theme, level, room_screen_loc, false)
	if saved_room != null:
		room_screen = saved_room
	room_screen.name = "room"
	add_child(room_screen)
	player.position = player_room_screen_loc
	current_game_state = game_state.room
#play animation for opening room.
#show the correct theme for the room. (instance -> room object) pull room art based on subtile type
#add deco using deco tiles based on room theme

#room should allow player to choose to interact or run/leave
#running from room would allow the player to return
#interact would cause the room to be removed (shop interact does not get removed)
#	current_tile.remove_center() ----------------------------add this line to remove the center when finished with the opened room
	return

func delete_centertile():
	var current_tile = player.current_tile
	current_tile.center_subtile.queue_free()
	for enemy in room_screen.enemies:
		enemy.queue_free()
	#play close room animation
	#unfreeze player 
	can_player_place_tiles = true
	player.position = player_last_loc
	player.walk_toggle()
	current_game_state = game_state.run
	return

func save_centertile():
	var current_tile = player.current_tile
	current_tile.saved_center_room = room_screen
	room_screen.is_saved_room = true
	#play close room animation
	#unfreeze player
	can_player_place_tiles = true
	player.position = player_last_loc
	player.walk_toggle()
	current_game_state = game_state.run
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
	Tile_Enums.multi.shuffle()
	var chosen_tile_type = Tile_Enums.multi[0]
	Tile_Enums.multi2.shuffle()
	var chosen_tile_center = Tile_Enums.multi2[0]
	#direction, theme, center, level, diff, deco amount, center level, chosen sprite(-1 for rand)
	tile = Tile.new(chosen_tile_type, chosen_level_theme, chosen_tile_center, stage_level, difficulty, 1, -1)
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
	start_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, stage_level, difficulty, 0, start_tile_sprite_index)
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
	end_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, stage_level, difficulty, 0, end_tile_sprite_index)
	end_tile.name = "End Tile"
	add_child(end_tile)
	end_tile.place_tile(picked_coord[0])
	#place preplaced tiles
	if gen_boss_tile == true:
		tile = Tile.new(Tile_Enums.tile_directions_enum.boss, chosen_level_theme, Tile_Enums.center_type_enum.none, stage_level, difficulty, 0, -1)
		tile.name = "Boss Tile"
		picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
		tile_dict[picked_coord[2]] = tile
		$InGameTileGroup.add_child(tile)
		tile.place_tile(picked_coord[3])
		tile.lock_tile()
		tile.is_boss_tile = true
	if num_impass_tiles > 0:
		while num_impass_tiles > 0:
			picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
			if start_tile.position.distance_to(picked_coord[3]) > 48 and end_tile.position.distance_to(picked_coord[3]) > 48:
				tile = Tile.new(Tile_Enums.tile_directions_enum.impass, chosen_level_theme, Tile_Enums.center_type_enum.none, stage_level, difficulty, 0, -1)
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
