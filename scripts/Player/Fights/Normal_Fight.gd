extends Node2D

class_name Normal_Fight

#generic room vars
var room_screen_loc #the location the room will appear on the player's screen
var enemy_node
var ani_sprite
var room_class

const starting_fight_turn_time = 0.5
const starting_ani_step_time = 0.2

var fight_turn_timer
var fight_turn_time = starting_fight_turn_time
var fight_fade_stage = false

var ani_step_timer
var current_ani_step

var ani_step_time = starting_ani_step_time
const top_fight_frames = 3
const bottom_fight_frames = 0
const top_fade_frames = 7
const bottom_fade_frames = 4

func _ready():
	add_to_group("fast_forward_grp")
	if GlobalVars.main_node_ref.is_fast_forwarded:
		fight_turn_time = starting_fight_turn_time/10
		ani_step_time = starting_ani_step_time/10
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/fight_cloud_frames.tres"))
	ani_sprite.set_frame(top_fight_frames)
	position = room_screen_loc
	add_child(ani_sprite)
	start_fight()

func fast_forward():
	fight_turn_time.set_wait_time(starting_fight_turn_time/10)
	ani_step_timer.set_wait_time(starting_ani_step_time/10)
	pass

func _init(passed_enemy_node, new_room_screen_loc):
	enemy_node = passed_enemy_node
	room_screen_loc = new_room_screen_loc

func start_fight():
	GlobalVars.player_node_ref.walk_toggle()
	enemy_node.walk_toggle()
	current_ani_step = top_fight_frames
	
	fight_turn_timer = Timer.new()
	fight_turn_timer.name = "Turn Timer"
	add_child(fight_turn_timer)
	fight_turn_timer.add_to_group("timers")
	fight_turn_timer.set_wait_time(fight_turn_time)
	fight_turn_timer.set_one_shot(false)
	fight_turn_timer.connect("timeout", self, "pass_fight_turn")
	fight_turn_timer.start()
	
	ani_step_timer = Timer.new()
	ani_step_timer.name = "Fight Ani Timer"
	add_child(ani_step_timer)
	ani_step_timer.add_to_group("timers")
	ani_step_timer.set_wait_time(ani_step_time)
	ani_step_timer.set_one_shot(false)
	ani_step_timer.connect("timeout", self, "ani_timer_step")
	ani_step_timer.start()
	pass

func pass_fight_turn():
	enemy_node.take_hit(GlobalVars.player_node_ref.type_class.starting_attack_power)
	if enemy_node.is_dead == true:
		finish_fight()
		return
	GlobalVars.player_node_ref.take_hit(enemy_node.type_class.damage)
	if GlobalVars.player_node_ref.is_dead == true:
		finish_fight()
		return
	pass

func ani_timer_step():
	if fight_fade_stage:
		fade_ani_step()
	else:
		fight_ani_step()
	pass

func fight_ani_step():
	current_ani_step -= 1
	ani_sprite.set_frame(current_ani_step)
	if current_ani_step <= 0:
		current_ani_step = top_fight_frames
	pass

func fade_ani_step():
	current_ani_step -= 1
	ani_sprite.set_frame(current_ani_step)
	if current_ani_step <= bottom_fade_frames:
		clean_up_fight()
	pass

func clean_up_fight():
	ani_step_timer.stop()
	queue_free()
	pass

func finish_fight():
	fight_turn_timer.stop()
	fight_fade_stage = true
	current_ani_step = top_fade_frames
	ani_sprite.set_frame(current_ani_step)
	if GlobalVars.player_node_ref.is_dead:
		pass
	else:
		GlobalVars.money_gained_this_run += enemy_node.type_class.reward
		get_tree().call_group("UI_Player_Info", "update_money")
		enemy_node.queue_free()
		GlobalVars.player_node_ref.walk_toggle()
	pass
