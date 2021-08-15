extends Node

class_name Action_Place_Tile

static func action():
	
	var current_tile
	var next_tile_node: Node2D = null
	var next_tile_coord
	var next_tile_coord_str
	var old_tile_coords
	var hero_tile_type
	var hero_tile_center
#	var tile_group_node: Node2D
	
	if GlobalVars.player_node_ref.current_tile == null:
		return false
	current_tile = GlobalVars.player_node_ref.current_tile
	hero_tile_type = GlobalVars.player_type_class_storage.tile_direction
	hero_tile_center = GlobalVars.player_type_class_storage.tile_center

#	tile_group_node = GlobalVars.main_node_ref.ingame_tilegroup_Node
	next_tile_coord = Vector2(current_tile.tile_loc_clickable_area.x + (GlobalVars.player_node_ref.direction.x *-1), current_tile.tile_loc_clickable_area.y + (GlobalVars.player_node_ref.direction.y *-1))
	next_tile_coord_str = str(next_tile_coord.x) +","+ str(next_tile_coord.y)
#	print(next_tile_coord_str)
	if next_tile_coord_str in GlobalVars.main_node_ref.tile_dict:
		if GlobalVars.main_node_ref.tile_dict[next_tile_coord_str] == null:
			return false
		
		if GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].is_player_built == true:
			return false
		
		next_tile_node = GlobalVars.main_node_ref.tile_dict[next_tile_coord_str]
		old_tile_coords = next_tile_node.position
		
		next_tile_node.delete_tile()
		var new_tile = Tile.new(hero_tile_type, GlobalVars.current_theme, hero_tile_center, 0, -1)
		new_tile.is_player_built = true
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str] = new_tile
		GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(new_tile)
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].place_tile(old_tile_coords)
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].tile_loc_clickable_area = next_tile_coord
		GlobalVars.main_node_ref.tile_dict[next_tile_coord_str].name = ("built_tile " + next_tile_coord_str)
		return true

