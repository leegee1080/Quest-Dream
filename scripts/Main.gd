extends Node2D

class_name Main_Game

var difficulty = 1
var player_level = 1
var player = Player.new(Player.player_types_enum.soldier, 0, difficulty, {})
var test_enemy = Enemy.new(Enemy.enemy_types_enum.rat, difficulty)
var chosen_level_theme = Tile_Enums.tile_themes_enum.castle

var gen_boss_tile = true
var num_impass_tiles = 3


##play area vars
var clicked
const starting_playarea_coord = [44,74] #x and y of the starting top corner of the play area
# [[xmin, xmax],[ymin, ymax], name of coord, middle vector of coord]
export(Array) var clickable_coords_list = []
var potential_terminal_locations = []
var start_tile
var end_tile
var tile_dict = {} #this is a dict more readable collection of tiles (string: tileobject)
var rows_total = 6
var col_total = 6

##queue area vars
const queue_length = 9
var tile_queue = []
const queue_loc_dict = {
	"0":Vector2(308,423),
	"1":Vector2(228,423),
	"2":Vector2(148,423),
	"3":Vector2(68,423),
	"4":Vector2(68,503),
	"5":Vector2(68,583),
	"6":Vector2(148,583),
	"7":Vector2(228,583),
	"8":Vector2(308,583)
}

func _ready():
	var start_timer = Timer.new()
	add_child(start_timer)
	start_timer.set_wait_time(60)
	start_timer.set_one_shot(true)
	start_timer.connect("timeout", self, "start_round")
	start_timer.start()
	setup_coord_array()
	setup_tile_dict()
	place_starting_tiles()
	add_child(player)
	player.name = player.type_class.name
	player.position = start_tile.position
	player.change_dir(player.walk_dir.up)
#	add_child(test_enemy)
#	test_enemy.name = test_enemy.type_class.name
#	test_enemy.position.x = 10
#	test_enemy.position.y = 200
	pass

func start_round():
	player.walk_toggle()
	return

func _input(event):
	if event is InputEventMouseButton:
		if clicked == true:
			clicked = false
			return
		clicked = true
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
					tile_dict[loc[2]].place_tile(loc[3], false)
					tile_dict[loc[2]].name = loc[2]
					slide_queue()
					return

func check_player_tile():
	for loc in clickable_coords_list:
			var x_test = loc[0]
			var y_test = loc[1]
			if player.position[0] >= x_test[0] and player.position[0] < x_test[1] and player.position[1] >= y_test[0] and player.position[1] < y_test[1]:
				if tile_dict.get(loc[2]) != null and tile_dict.get(loc[2]).is_locked == false:
					#react to tile
					return
				elif tile_dict.get(loc[2]) == null and tile_queue.size()>0:
					#turn player around
					return
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
	tile = Tile.new(chosen_tile_type, chosen_level_theme, chosen_tile_center, player_level, difficulty, 1, 0, -1)
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
	#work on start tile
	var start_tile_index = int(rand_range(0,potential_terminal_locations.size())) #so that the entry can be removed later insuring the end and start are not on the same tile
	var start_tile_sprite_index = 0
	picked_coord = potential_terminal_locations[start_tile_index]
	if picked_coord[1].y == 1:
		start_tile_sprite_index = 2
	elif picked_coord[1].y == rows_total:
		start_tile_sprite_index = 3
	elif picked_coord[1].x == 1:
		start_tile_sprite_index = 0
	elif picked_coord[1].x == col_total:
		start_tile_sprite_index = 1
	start_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0, start_tile_sprite_index)
	add_child(start_tile)
	start_tile.place_tile(picked_coord[0], true)
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
	end_tile = Tile.new(Tile_Enums.tile_directions_enum.terminal, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0, end_tile_sprite_index)
	add_child(end_tile)
	end_tile.place_tile(picked_coord[0], true)
	#place preplaced tiles
	if gen_boss_tile == true:
		tile = Tile.new(Tile_Enums.tile_directions_enum.boss, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0, -1)
		picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
		tile_dict[picked_coord[2]] = tile
		$InGameTileGroup.add_child(tile)
		tile.place_tile(picked_coord[3], true)
		tile.is_boss_tile = true
	if num_impass_tiles > 0:
		while num_impass_tiles > 0:
			picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
			if start_tile.position.distance_to(picked_coord[3]) > 48 and end_tile.position.distance_to(picked_coord[3]) > 48:
				tile = Tile.new(Tile_Enums.tile_directions_enum.impass, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0, -1)
				tile_dict[picked_coord[2]] = tile
				$InGameTileGroup.add_child(tile)
				tile.place_tile(picked_coord[3], true)
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
