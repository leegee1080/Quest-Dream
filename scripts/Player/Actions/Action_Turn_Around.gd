extends Node

class_name Action_Turn_Around

static func action():
	if GlobalVars.player_node_ref.current_tile == null:
		return false
	if GlobalVars.player_node_ref.current_tile.center_object_enum == null or GlobalVars.player_node_ref.current_tile.center_object_enum == Tile_Enums.center_type_enum.none:
		GlobalVars.player_node_ref.current_tile.center_object_enum = Tile_Enums.center_type_enum.reverse
		GlobalVars.player_node_ref.current_tile.place_center()
		return true
	return false
