extends Node

class_name Action_Place_Tile

static func action(param1, param2):
	if param1 in Tile_Enums.tile_directions_enum:
		if param2 in Tile_Enums.center_type_enum:
			for loc in GlobalVars.main_node_ref.clickable_coords_list:
				var x_test = loc[0]
				var y_test = loc[1]
				if GlobalVars.player_node_ref.position[0] >= x_test[0] and GlobalVars.player_node_ref.position[0] < x_test[1] and GlobalVars.player_node_ref.position[1] >= y_test[0] and GlobalVars.player_node_ref.position[1] < y_test[1]:
					if GlobalVars.main_node_ref.tile_dict.get(loc[2]) != null and (GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_player_built or GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_terminal_tile):
						return
					if GlobalVars.main_node_ref.tile_dict.get(loc[2]) != null:
						GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_locked = false
						GlobalVars.main_node_ref.tile_dict.get(loc[2]).delete_tile()
						GlobalVars.main_node_ref.tile_dict[loc[2]] = null
					#assign the new tile node to the correct dictionary entry
					var new_tile = Tile.new(GlobalVars.player_type_class_storage.tile_direction, GlobalVars.current_theme, GlobalVars.player_type_class_storage.tile_center, 0, -1)
					new_tile.is_player_built = true
					GlobalVars.main_node_ref.tile_dict[loc[2]] = new_tile
					GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(new_tile)
					GlobalVars.main_node_ref.tile_dict[loc[2]].place_tile(loc[3])
					GlobalVars.main_node_ref.tile_dict[loc[2]].name = "built_tile " + str(loc[2])
					
					GlobalVars.player_consumable_amount -= GlobalVars.player_type_class_storage.action_cost
#					get_tree().call_group("UI_Player_Info", "update_consumable")
					GlobalVars.player_node_ref.check_for_death()
					GlobalVars.player_node_ref.map_action_queued = false
