extends Node2D

class_name Class_Select_Screen

const hero_select_back_button_loc_dict = {
	"back": [Vector2(121,371), 0, 1]
}

const hero_select_starting_vect = Vector2(41,214)
var hero_select_button_spacing = Vector2(80,80)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const rtl_text_scale = 0.1
const rtl_rect_size = Vector2(50,50)

const hero_sprite_sheet = preload("res://assets/visuals/player_frames.tres")

var unlocked_heroes = []

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
		UiVars.generate_button(temp_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "hero_select_buttons", 0, self)
		var sprite = AnimatedSprite.new()
		sprite.set_sprite_frames(hero_sprite_sheet)
		sprite.set_frame(Player_Enums.player_types_string_dict.get(entry).sprite_frame)
		sprite.position = Vector2(hero_select_starting_vect.x + (hero_select_button_spacing.x * index_x) + 10,hero_select_starting_vect.y + (hero_select_button_spacing.y * index_y) + 10)
#		print(Player_Enums.player_types_string_dict.get(entry).sprite_frame)
		sprite.z_index = 16
		sprite.centered = false
		sprite.modulate = Color(0,0,0)

		var rtl_node = Label.new()
		add_child(rtl_node)
		rtl_node.rect_position = Vector2(sprite.position.x + 20, sprite.position.y)
		rtl_node.rect_scale = Vector2(rtl_text_scale,rtl_text_scale)
		rtl_node.rect_size = rtl_rect_size
		rtl_node.text = str(Player_Enums.player_types_string_dict.get(entry).unlock_cost)
		rtl_node.add_font_override("font", load(font))
#		rtl_node.z_index = 16
		
		if Player_Enums.player_types_enum[entry] in get_parent().unlocked_classes:
			sprite.modulate = Color(1,1,1)
			unlocked_heroes.append(entry)
		add_child(sprite)
		index_x += 1
		if index_x >= 3:
			index_x = 0
			index_y += 1
		pass
	pass

func ui_func(new_name, _btn_node_ref): #checks which button is pressed
	print(new_name)
	if new_name in unlocked_heroes:
		get_parent().player_type_class = Player_Enums.player_types_string_dict.get(new_name)
		get_parent().ui_func("newgame", null)
	else:
		print("ask to unlock hero")
