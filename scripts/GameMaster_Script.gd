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
const mainmenu_button_z_index = 15
const mainmenu_button_loc_dict = {
	#fill with the locations to instance the button objects
	"new": [Vector2(49,301), 0, 1],
	"load": [Vector2(119,301), 6, 7],
	"option": [Vector2(189,301), 2, 3],
	"credit": [Vector2(189,301), 2, 3],
	"exit": [Vector2(189,301), 2, 3]
}

#overall gamestage
var current_game_state
enum game_state{
	setup,
	stage,
	lose,
	win,
	mainmenu
}

func _ready():
	current_game_state = game_state.mainmenu
#	UI_Vars.generate_button(mainmenu_button_loc_dict, "res://assets/visuals/small_button_frames.tres", Vector2(66,66), "room_back_btn", mainmenu_button_z_index, self)
	add_child(trans_timer)
	trans_timer = Timer.new()
	add_child(trans_timer)
	trans_timer.set_wait_time(trans_total_time)
	trans_timer.set_one_shot(true)
	trans_timer.connect("timeout", self, "end_scene_trans")
	
	current_game_state = game_state.setup
	start_scene_trans()
	pass

func start_scene_trans():
	if current_stage != null:
		current_stage.queue_free()
	trans_timer.start()
	pass

func end_scene_trans():
	if current_game_state == game_state.setup:
		GlobalVars.player_type_class_storage = Player_Enums.player_types_dict[player_type_class].new()
		add_child(GlobalVars.player_type_class_storage)
		GlobalVars.player_type_class_storage.name = "Player_Data_Storage"
		generate_enemies_dict()
		create_stage(chosen_level_theme)
		add_child(current_stage)
		current_game_state = game_state.stage
		return
	if current_game_state == game_state.mainmenu:
		get_tree().quit()
		return
	if current_game_state == game_state.win:
		create_stage(chosen_level_theme)
		add_child(current_stage)
		return
	if current_game_state == game_state.lose:
		current_game_state = game_state.mainmenu
		get_tree().quit() #just for now until there is a main menu
		return
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if cheats:
				if event.scancode == KEY_W:
					current_stage.win_round()
					return
				if event.scancode == KEY_N:
					create_stage(chosen_level_theme)
					add_child(current_stage)
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
	current_stage.name = "Stage" + str(GlobalVars.current_stage)
	pass

func generate_enemies_dict():
	for test in Enemy_Enums.enemy_types_dict:
		var test_enemy = Enemy_Enums.enemy_types_dict[test].new()
		if test_enemy.is_final_boss:
			GlobalVars.stage_enemies_dict[test_enemy.theme][1].append(Enemy_Enums.enemy_types_dict[test])
		else:
			GlobalVars.stage_enemies_dict[test_enemy.theme][0].append(Enemy_Enums.enemy_types_dict[test])

func exit_to_menu():
	current_game_state = game_state.mainmenu
	print("play screen wipe")
	print("go back to main menu")
	start_scene_trans()
	pass

func lose_stage():
	current_game_state = game_state.lose
	print("play screen wipe")
	print("You died!")
	print("go back to main menu")
	start_scene_trans()
	pass

func win_stage():
	current_game_state = game_state.win
	print("play screen wipe")
	print("You continue on!")
	print("show skill picker on next stage")
	start_scene_trans()
	pass
