extends Node2D

var difficulty = 1
var player_level = 1
var player = Player.new(Player.player_types_enum.soldier, 0, difficulty, {})
var test_enemy = Enemy.new(Enemy.enemy_types_enum.rat, difficulty)
var chosen_level_theme = Tile_Enums.tile_themes_enum.mountain

var gen_boss_tile =  true
var num_impass_tiles = 3

##play area vars
var clicked
const starting_playarea_coord = [43,73]
# [[xmin, xmax],[ymin, ymax], name of coord, middle vector of coord]
export(Array) var clickable_coords_list = []
var tile_dict = {}
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
	add_child(player)
	player.name = player.type_class.name
	player.position.x = 10
	player.position.y = 100
	add_child(test_enemy)
	test_enemy.name = test_enemy.type_class.name
	test_enemy.position.x = 10
	test_enemy.position.y = 200
	setup_coord_array()
	setup_tile_dict()
	place_starting_tiles()
	pass

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
					return
				elif tile_dict.get(loc[2]) == null and tile_queue.size()>0:
					#assign the new tile node to the correct dictionary entry
					tile_dict[loc[2]] = tile_queue[0]
					tile_dict[loc[2]].place_tile(loc[3], false)
					slide_queue()
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
	new_tile.name = "8"
	new_tile.position.x = queue_loc_dict.get("8").x
	new_tile.position.y = queue_loc_dict.get("8").y
	return

func generate_random_tile():
	var tile
	randomize()
	Tile_Enums.multi.shuffle()
	var chosen_tile_type = Tile_Enums.multi[0]
	Tile_Enums.multi2.shuffle()
	var chosen_tile_center = Tile_Enums.multi2[0]
	#direction, theme, center, level, diff, deco amount, center level
	tile = Tile.new(chosen_tile_type, chosen_level_theme, chosen_tile_center, player_level, difficulty, 1, 0)
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
	var rows = rows_total
	var current_x = starting_playarea_coord[0]
	var current_y = starting_playarea_coord[1]
	while col > 0:
		rows = rows_total
		current_y = starting_playarea_coord[1]
		while rows > 0:
			clickable_coords_list.append([[current_x,current_x+48],[current_y,current_y+48],str(col)+","+str(rows), Vector2(current_x+24, current_y+24)])
			current_y += 48
			rows -= 1
		current_x += 48
		col -= 1
#	print(clickable_coords_list)
	return

func place_starting_tiles():
	var tile

	#place preplaced tiles
	if gen_boss_tile == true:
		tile = Tile.new(Tile_Enums.tile_directions_enum.boss, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0)
		var picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
		tile_dict[picked_coord[2]] = tile
		$InGameTileGroup.add_child(tile)
		tile.place_tile(picked_coord[3], true)
	if num_impass_tiles > 0:
		while num_impass_tiles > 0:
			tile = Tile.new(Tile_Enums.tile_directions_enum.impass, chosen_level_theme, Tile_Enums.center_type_enum.none, player_level, difficulty, 0, 0)
			var picked_coord = clickable_coords_list[int(rand_range(0,clickable_coords_list.size()))]
			tile_dict[picked_coord[2]] = tile
			$InGameTileGroup.add_child(tile)
			tile.place_tile(picked_coord[3], true)
			num_impass_tiles -= 1


	#start queue
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
