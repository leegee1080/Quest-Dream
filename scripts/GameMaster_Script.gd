extends Node2D

var cheats = true
var player_type_class = Player_Enums.player_types_enum.assassin
var chosen_level_theme = Tile_Enums.tile_themes_enum.forest

var current_stage: Node2D

#const vars for the stage reset:
const battle_participants_node_array = []
const tile_path_type_chance_array = []
const tile_center_chance_array = []

#ui vars
var trans_timer = Timer.new()
var trans_total_time = 0.5
var trans_middle_timer = Timer.new()
const mainmenu_button_z_index = 15
const mainmenu_button_loc_dict = {
	#fill with the locations to instance the button objects
	"newgame": [Vector2(79,291), 8, 9],
	"continuegame": [Vector2(159,291), 10, 11],
	"options": [Vector2(79,371), 12, 13],
	"credits": [Vector2(159,371), 14, 15]
}
const optionsmenu_button_loc_dict = {
	"back": [Vector2(189,301), 0, 1]
}

#overall gamestage
var current_game_state
var next_game_state
enum game_state{
	setup,
	continuegame,
	newgame,
	options,
	credits,
	stage,
	lose,
	win,
	mainmenu
}

func _ready():
	trans_timer = Timer.new()
	add_child(trans_timer)
	trans_timer.set_wait_time(trans_total_time)
	trans_timer.set_one_shot(true)
	trans_timer.connect("timeout", self, "end_scene_trans")
	
	trans_middle_timer = Timer.new()
	add_child(trans_middle_timer)
	trans_middle_timer.set_wait_time(trans_total_time/2)
	trans_middle_timer.set_one_shot(true)
	trans_middle_timer.connect("timeout", self, "middle_scene_trans")
	
	setup_mainmenu()
	pass

func setup_mainmenu():
	current_game_state = game_state.mainmenu
	UiVars.generate_button(mainmenu_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "mainmenu_buttons", mainmenu_button_z_index, self)
	pass

func start_scene_trans():
	trans_timer.start()
	trans_middle_timer.start()
	UiVars.is_trans = true
	pass

func middle_scene_trans():
	if current_game_state == game_state.mainmenu:
		UiVars.hide_buttons("mainmenu_buttons")
	if current_stage != null:
		current_stage.queue_free()
	if GlobalVars.current_stage_number in GlobalVars.stage_order:
		chosen_level_theme = GlobalVars.stage_order[GlobalVars.current_stage_number]
	pass

func end_scene_trans():
	UiVars.is_trans = false
	if next_game_state == game_state.newgame:
		GlobalVars.player_type_class_storage = Player_Enums.player_types_dict[player_type_class].new()
		add_child(GlobalVars.player_type_class_storage)
		GlobalVars.player_type_class_storage.name = "Player_Data_Storage"
		generate_enemies_dict()
		create_stage(chosen_level_theme)
		add_child(current_stage)
		current_game_state = game_state.stage
		return
	if next_game_state == game_state.continuegame:
		print("cont")
		current_game_state = game_state.stage
		return
	if next_game_state == game_state.mainmenu:
		current_game_state = game_state.mainmenu
		setup_mainmenu()
		return
	if next_game_state == game_state.win:
		current_game_state = game_state.stage
		create_stage(chosen_level_theme)
		add_child(current_stage)
		return
	if next_game_state == game_state.lose:
		current_game_state = game_state.mainmenu
		setup_mainmenu()
		return
	pass

func ui_func(new_name, _btn_node_ref): #checks which button is pressed
	if UiVars.is_trans:
		return
	if new_name == "back":
		ui_back(_btn_node_ref)
		return
	if new_name == "continuegame":
		ui_cont()
		return
	if new_name == "options":
		ui_options()
		return
	if new_name == "credits":
		ui_credits()
		return
	if new_name == "newgame":
		ui_new()
		return

func ui_back(button_node_ref):
	pass

func ui_new():
	next_game_state = game_state.newgame
	start_scene_trans()
	pass

func ui_cont():
	next_game_state = game_state.continuegame
	start_scene_trans()
	pass

func ui_options():
	next_game_state = game_state.options
	pass

func ui_credits():
	next_game_state = game_state.credits
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if cheats:
				if event.scancode == KEY_W:
					current_stage.win_round()
					return
				if event.scancode == KEY_N:
					win_stage()
					return
				if event.scancode == KEY_SPACE and current_stage.current_game_state != current_stage.game_state.boss and current_stage.current_game_state == current_stage.game_state.run:
					current_stage.open_boss_room()
					return

func create_stage(passed_theme):
	GlobalVars.battle_participants_node_array = battle_participants_node_array
	GlobalVars.tile_path_type_chance_array = tile_path_type_chance_array
	GlobalVars.tile_center_chance_array = tile_center_chance_array
	GlobalVars.current_theme = chosen_level_theme
	current_stage = Stage.new(passed_theme)
	current_stage.name = "Stage" + str(GlobalVars.current_stage_number)
	pass

func generate_enemies_dict():
	for test in Enemy_Enums.enemy_types_dict:
		var test_enemy = Enemy_Enums.enemy_types_dict[test].new()
		if test_enemy.is_final_boss:
			GlobalVars.stage_enemies_dict[test_enemy.theme][1].append(Enemy_Enums.enemy_types_dict[test])
		else:
			GlobalVars.stage_enemies_dict[test_enemy.theme][0].append(Enemy_Enums.enemy_types_dict[test])

func exit_to_menu():
	next_game_state = game_state.mainmenu
	print("play screen wipe")
	print("go back to main menu")
	start_scene_trans()
	pass

func lose_stage():
	next_game_state = game_state.lose
	print("play screen wipe")
	print("You died!")
	print("go back to main menu")
	start_scene_trans()
	pass

func win_stage():
	GlobalVars.current_stage_number += 1
	next_game_state = game_state.win
	print("play screen wipe")
	print("You continue on!")
	print("show skill picker on next stage")
	start_scene_trans()
	pass
