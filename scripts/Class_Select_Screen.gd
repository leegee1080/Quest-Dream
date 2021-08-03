extends Node2D

class_name Class_Select_Screen

const hero_select_back_button_loc_dict = {
	"back": [Vector2(121,371), 0, 1]
}

const hero_select_starting_vect = Vector2(41,214)
var hero_select_button_spacing = Vector2(80,80)

const hero_sprite_sheet = "res://assets/visuals/player_frames.tres"

func _ready():
	name = "Class_Select_Screen"
#	UiVars.generate_button(hero_select_back_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "class_select_back_button", 15, get_parent())
	generate_buttons()
	pass

func generate_buttons():
	var temp_loc_dict = {"select": [Vector2(hero_select_starting_vect.x,hero_select_starting_vect.y), 18, 19]}
	var index_x = 0
	var index_y = 0
	for entry in Player_Enums.player_types_enum:
		temp_loc_dict = {entry: [Vector2(hero_select_starting_vect.x + (hero_select_button_spacing.x * index_x),hero_select_starting_vect.y + (hero_select_button_spacing.y * index_y)), 18, 19]}
		UiVars.generate_button(temp_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "hero_select_buttons", 15, self)
		index_x += 1
		if index_x >= 3:
			index_x = 0
			index_y += 1
		pass
		print(Player_Enums.player_types_string_dict.get(entry).sprite_frame)
	pass

func ui_func(new_name, _btn_node_ref): #checks which button is pressed
	print(new_name)
	get_parent().player_type_class = Player_Enums.player_types_string_dict.get(new_name)
	get_parent().ui_func("newgame", null)
