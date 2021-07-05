extends Node2D

class_name Boss_Room

var battle_player
var boss
var enemies = []
#var turn_order_array = []
#var turn_index = 0
#const turn_counter_time = 1
#var turn_timer

var ani_sprite

func _init():
	pass

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	add_child(ani_sprite)
	ani_sprite.set_frame(Room_Enums.room_theme_dict[GlobalVars.current_theme])
	setup_battle()

func setup_battle():
	randomize()
#	var spawn_pos = Vector2(rand_range(GlobalVars.main_node_ref.content_room_screen_loc.x - 20, GlobalVars.main_node_ref.content_room_screen_loc.x + 20), rand_range(GlobalVars.main_node_ref.content_room_screen_loc.y - 20, GlobalVars.main_node_ref.content_room_screen_loc.y + 20))
	var boss_stage_index = 0
	if GlobalVars.current_stage % 5 == 0:
		boss_stage_index = 1
	var boss_index = int(rand_range(0, GlobalVars.stage_enemies_dict[GlobalVars.current_theme][boss_stage_index].size()))
	print(boss_index)
	boss = Enemy.new(GlobalVars.stage_enemies_dict[GlobalVars.current_theme][boss_stage_index][boss_index])
	battle_player = Room_Player.new()
	
	GlobalVars.main_node_ref.add_child(boss)
	boss.position = GlobalVars.main_node_ref.content_room_screen_loc
	GlobalVars.battle_participants_node_array.append(boss)
	
	GlobalVars.main_node_ref.add_child(battle_player)
	battle_player.position = GlobalVars.main_node_ref.player_room_screen_loc

func complete_battle():
	get_parent().complete_room()
