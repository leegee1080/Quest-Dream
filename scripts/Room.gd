extends Node2D

class_name Room

var generic_room_types = Room_Type.new()
var type_enum
var theme_enum
var type_stats
var theme_stats


func _ready():
	generate_room_stats()

func _init(new_type, new_theme):
	self.type_enum = new_type
	self.theme_enum = new_theme

func generate_room_stats():
	if self.type_enum == null:
		self.type_enum = generic_room_types.room_types_enum
		self.theme_enum = generic_room_types.tile_themes_enum
	self.type_stats = generic_room_types.room_types_dict.get(self.type_enum)
	self.theme_stats = generic_room_types.room_themes_dict.get(self.theme_enum)
	print(self.type_stats.get("name"))

func generate_room():
	return

func player_access_room():
	return
