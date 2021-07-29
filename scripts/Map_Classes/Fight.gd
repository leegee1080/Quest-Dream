extends Node2D

class_name Fight

#generic room vars
var room_screen_loc #the location the room will appear on the player's screen
var enemy_node
var ani_sprite
var room_class

var fight_overall_timer
var fight_overall_time = 0.5
var fight_turn_timer
var fight_turn_time = 0.1
const total_turn_frames = 4
var current_turn_frame = total_turn_frames

func _ready():
	add_to_group("fast_forward_grp")
	if GlobalVars.main_node_ref.is_fast_forwarded:
		fight_overall_time = fight_overall_time/10
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/room_bg_frames.tres"))
	ani_sprite.set_frame(total_turn_frames)
	position = room_screen_loc
	add_child(ani_sprite)
	start_fight()

func fast_forward():
	fight_overall_timer.set_wait_time(fight_overall_time/10)
	pass

func _init(passed_enemy_node, new_room_screen_loc):
	enemy_node = passed_enemy_node
	room_screen_loc = new_room_screen_loc

func start_fight():
	GlobalVars.player_node_ref.walk_toggle()
	enemy_node.walk_toggle()
	
	fight_overall_timer = Timer.new()
	fight_overall_timer.name = "Fight Timer"
	add_child(fight_overall_timer)
	fight_overall_timer.add_to_group("timers")
	fight_overall_timer.set_wait_time(fight_overall_time)
	fight_overall_timer.set_one_shot(true)
	fight_overall_timer.connect("timeout", self, "finish_fight")
	fight_overall_timer.start()
	
	fight_turn_timer = Timer.new()
	fight_turn_timer.name = "Turn Timer"
	add_child(fight_turn_timer)
	fight_turn_timer.add_to_group("timers")
	fight_turn_timer.set_wait_time(fight_turn_time)
	fight_turn_timer.set_one_shot(false)
	fight_turn_timer.connect("timeout", self, "pass_fight_turn")
	fight_turn_timer.start()
	pass

func pass_fight_turn():
	current_turn_frame -= 1
	ani_sprite.set_frame(current_turn_frame)
	enemy_node.take_hit(GlobalVars.player_node_ref.type_class.starting_attack_power)
	if enemy_node.is_dead:
		finish_fight()
		return
	GlobalVars.player_node_ref.take_hit(enemy_node.type_class.damage)
	if GlobalVars.player_node_ref.is_dead:
		finish_fight()
		return
	if current_turn_frame <= 0:
		current_turn_frame = total_turn_frames
	pass

func finish_fight():
	fight_turn_timer.stop()
	if GlobalVars.player_node_ref.is_dead:
		fight_overall_timer.stop()
	else:
		enemy_node.queue_free()
		GlobalVars.player_node_ref.walk_toggle()
	queue_free()
	pass
