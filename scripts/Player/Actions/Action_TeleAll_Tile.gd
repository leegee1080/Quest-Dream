extends Node

class_name Action_TeleAll_Tile

static func action():
	var current_tile
	var next_tile_node: Node2D = null
	var next_tile_coord
	var next_tile_coord_str
	var old_tile_coords
	var hero_tile_type
	var hero_tile_center
	
	if GlobalVars.player_node_ref.current_tile == null:
		return false
	
	current_tile = GlobalVars.player_node_ref.current_tile
	hero_tile_type = GlobalVars.player_type_class_storage.tile_direction
	hero_tile_center = GlobalVars.player_type_class_storage.tile_center
	
	var farthest_tile_dict = {
		Vector2(0,0): null,
		Vector2(1,0): Vector2(1, current_tile.tile_loc_clickable_area.y),
		Vector2(-1,0): Vector2(5, current_tile.tile_loc_clickable_area.y),
		Vector2(0,1): Vector2(current_tile.tile_loc_clickable_area.x, 1),
		Vector2(0,-1): Vector2(current_tile.tile_loc_clickable_area.x, 5)
	}
	
	next_tile_coord = farthest_tile_dict[GlobalVars.player_node_ref.direction]
	next_tile_coord_str = str(next_tile_coord.x) +","+ str(next_tile_coord.y)
	
	if next_tile_coord_str in GlobalVars.main_node_ref.tile_dict:
		if GlobalVars.main_node_ref.tile_dict[next_tile_coord_str] == null:
			for item in GlobalVars.main_node_ref.clickable_coords_list:
				if item[2] == next_tile_coord_str:
					old_tile_coords = item[3]
			pass
		else:
			if GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].is_player_built == true:
				return false
			next_tile_node = GlobalVars.main_node_ref.tile_dict[next_tile_coord_str]
			print(next_tile_node.name)
			old_tile_coords = next_tile_node.position
			next_tile_node.queue_free()
			pass
		
		GlobalVars.player_node_ref.walk_toggle()
		var particle1 = TeleportAway.new(GlobalVars.player_node_ref.position)
		GlobalVars.main_node_ref.add_child(particle1)
	#	#jump
	
	#	#land
		var new_tile = Tile.new(hero_tile_type, GlobalVars.current_theme, hero_tile_center, 0, -1)
		new_tile.is_player_built = true
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str] = new_tile
		GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(new_tile)
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].place_tile(old_tile_coords)
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].tile_loc_clickable_area = next_tile_coord
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].name = ("built_tile " + next_tile_coord_str)
	
		GlobalVars.player_node_ref.current_tile = new_tile
		GlobalVars.player_node_ref.position = old_tile_coords
		GlobalVars.player_node_ref.check_center_tile()
		GlobalVars.player_node_ref.center_interval_count = 0
		GlobalVars.player_node_ref.walk_interval_count = 15.7
		GlobalVars.player_node_ref.direction = (GlobalVars.player_node_ref.direction *-1)
		GlobalVars.player_node_ref.walk_toggle()
		var particle2 = TeleportBack.new(GlobalVars.player_node_ref.position)
		GlobalVars.main_node_ref.add_child(particle2)
		GlobalVars.audio_player.play("teleport")
		return true
	else:
		return false
