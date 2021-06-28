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
	
#	turn_timer = Timer.new()
#	turn_timer.name = "Leave Timer"
#	get_parent().timer_group.add_child(turn_timer)
#	turn_timer.set_wait_time(turn_counter_time)
#	turn_timer.set_one_shot(false)
#	turn_timer.connect("timeout", self, "turn_timer_tick")
	setup_battle()

func setup_battle():
	randomize()
#	var spawn_pos = Vector2(rand_range(GlobalVars.main_node_ref.content_room_screen_loc.x - 20, GlobalVars.main_node_ref.content_room_screen_loc.x + 20), rand_range(GlobalVars.main_node_ref.content_room_screen_loc.y - 20, GlobalVars.main_node_ref.content_room_screen_loc.y + 20))
	var boss_stage_index = 0
	if GlobalVars.current_stage % 5 == 0:
		boss_stage_index = 1
	var boss_index = int(rand_range(0, GlobalVars.stage_enemies_dict[GlobalVars.current_theme][boss_stage_index].size()))
	boss = Enemy.new(GlobalVars.stage_enemies_dict[GlobalVars.current_theme][boss_stage_index][boss_index])
	battle_player = Room_Player.new()

#	turn_order_array.append(battle_player)
#	turn_order_array.append(boss)
	
	GlobalVars.main_node_ref.add_child(boss)
	boss.position = GlobalVars.main_node_ref.content_room_screen_loc
	GlobalVars.battle_participants_node_array.append(boss)
	
	GlobalVars.main_node_ref.add_child(battle_player)
	battle_player.position = GlobalVars.main_node_ref.player_room_screen_loc
	
#	turn_timer.start()

#func refresh_enemy_array():
#	var temp_list = turn_order_array
#	for item in turn_order_array:
#		if item.is_dead == false:
#			temp_list.append(item)
#		pass
#	turn_order_array = temp_list
#	pass
#
##check for deaths func's
#func check_player_death():
#	if battle_player.is_dead:
#		return true
#	return false
#
#func check_enemies_death():
#	var all_enemies_dead = true
#	for test in enemies:
#		if test.is_dead == false:
#			all_enemies_dead = false
#	if all_enemies_dead:
#		complete_battle()

func complete_battle():
	get_parent().complete_room()
