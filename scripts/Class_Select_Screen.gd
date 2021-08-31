extends Node2D

class_name Class_Select_Screen

const hero_select_back_button_loc_dict = {
	"back": [Vector2(121,371), 0, 1]
}

const hero_confirm_button_loc_dict = {
	"confirm_back": [Vector2(76,387), 0, 1],
	"confirm_forward": [Vector2(162,387), 16, 17]
}
const confrim_menu_loc = Vector2(152,343)
const confirm_menu_sprite_sheet = preload("res://assets/visuals/hero_tip_frames.tres")
var confirm_menu_anisprite
var player_is_confirming = false

const hero_select_starting_vect = Vector2(50,234)
var hero_select_button_spacing = Vector2(69,46)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const rtl_text_scale = 0.1
const rtl_rect_size = Vector2(50,50)

const hero_sprite_sheet = preload("res://assets/visuals/player_frames.tres")

var unlocked_heroes = []
var money_ui_node

func _ready():
	name = "Class_Select_Screen"
	UiVars.generate_button(hero_select_back_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "class_select_back_button", 5, get_parent())
	generate_buttons()
	
	money_ui_node = UI_MainMenu_Player_Info.new(Vector2(132,221))
	money_ui_node.name = "UI Money"
	add_child(money_ui_node)
	pass

func generate_buttons():
#	var temp_loc_dict = {"select": [Vector2(hero_select_starting_vect.x,hero_select_starting_vect.y), 18, 19]}
	UiVars.buttons_dict["hero_select_buttons"] = []
	var index_x = 0
	var index_y = 0
	var all_button_loc_dict = {}
	var all_rtl_nodes = []
	var all_sprite_nodes = []
	for entry in Player_Enums.player_types_enum:
#		temp_loc_dict = {entry: [Vector2(hero_select_starting_vect.x + (hero_select_button_spacing.x * index_x),hero_select_starting_vect.y + (hero_select_button_spacing.y * index_y)), 0, 1]}
#		UiVars.generate_button(temp_loc_dict, "res://assets/visuals/button_hero.tres", Vector2(66,41), "hero_select_buttons", 0, self)
		all_button_loc_dict[entry] =  [Vector2(hero_select_starting_vect.x + (hero_select_button_spacing.x * index_x),hero_select_starting_vect.y + (hero_select_button_spacing.y * index_y)), 0, 1]
		var sprite = AnimatedSprite.new()
		sprite.name = str(entry + " sprite")
		sprite.set_sprite_frames(hero_sprite_sheet)
		sprite.set_frame(Player_Enums.player_types_string_dict.get(entry)[0].sprite_frame)
		sprite.position = Vector2(hero_select_starting_vect.x + (hero_select_button_spacing.x * index_x) + 10,hero_select_starting_vect.y + (hero_select_button_spacing.y * index_y) + 12)
		sprite.z_index = 1
		sprite.centered = false
		sprite.modulate = Color(0,0,0)

		var rtl_node = Label.new()
#		add_child(rtl_node)
		rtl_node.name = str(entry + " rtl")
		rtl_node.rect_position = Vector2(sprite.position.x + 18, sprite.position.y)
		rtl_node.rect_scale = Vector2(rtl_text_scale,rtl_text_scale)
		rtl_node.rect_size = rtl_rect_size
		rtl_node.text = str(Player_Enums.player_types_string_dict.get(entry)[0].unlock_cost)
		rtl_node.add_font_override("font", load(font))
		UiVars.buttons_dict["hero_select_buttons"].append(rtl_node)
		
		if Player_Enums.player_types_enum[entry] in get_parent().unlocked_classes:
			rtl_node.text = "GO!"
			sprite.modulate = Color(1,1,1)
			unlocked_heroes.append(entry)
		all_sprite_nodes.append(sprite)
		all_rtl_nodes.append(rtl_node)
#		add_child(sprite)
#		UiVars.buttons_dict["hero_select_buttons"].append(sprite)
		index_x += 1
		if index_x >= 3:
			index_x = 0
			index_y += 1
		pass
	UiVars.generate_button(all_button_loc_dict, "res://assets/visuals/button_hero.tres", Vector2(66,41), "hero_select_buttons", 0, self)
	for sprt in all_sprite_nodes:
		add_child(sprt)
#		UiVars.buttons_dict["hero_select_buttons"].append(sprt)
	for rtl in all_rtl_nodes:
		add_child(rtl)
#		UiVars.buttons_dict["hero_select_buttons"].append(rtl)
	pass

func ui_func(new_name, _btn_node_ref): #checks which button is pressed
	if new_name == "confirm_forward":
		get_parent().ui_func("newgame", null)
		return
	if new_name == "confirm_back":
		if confirm_menu_anisprite != null:
			confirm_menu_anisprite.queue_free()
			UiVars.hide_buttons("hero_confirm_buttons")
			UiVars.enable_button("hero_select_buttons")
			UiVars.enable_button("class_select_back_button")
		return
	if new_name in unlocked_heroes:
		get_parent().player_type_class = Player_Enums.player_types_string_dict.get(new_name)[0]
		confirm_menu_anisprite = AnimatedSprite.new()
		confirm_menu_anisprite.position = confrim_menu_loc
		confirm_menu_anisprite.set_sprite_frames(confirm_menu_sprite_sheet)
		confirm_menu_anisprite.z_index = 10
		confirm_menu_anisprite.set_frame(Player_Enums.player_types_string_dict.get(new_name)[0].sprite_frame)
		add_child(confirm_menu_anisprite)
		UiVars.generate_button(hero_confirm_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,41), "hero_confirm_buttons", 15, self)
		UiVars.disable_button("hero_select_buttons")
		UiVars.disable_button("class_select_back_button")
	else:
		if GlobalVars.money_gained_total >= Player_Enums.player_types_string_dict.get(new_name)[0].unlock_cost:
			get_parent().msg_node.run_msg("Hero Unlock!")
			GlobalVars.audio_player.play("unlock")
			get_parent().unlocked_classes.append(Player_Enums.player_types_string_dict.get(new_name)[1])
			GlobalVars.money_gained_total -= Player_Enums.player_types_string_dict.get(new_name)[0].unlock_cost
			money_ui_node.update_money()
			UiVars.hide_buttons("hero_select_buttons")
			generate_buttons()
			pass
		else:
			GlobalVars.audio_player.play("notunlock")

