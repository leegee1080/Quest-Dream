extends Node2D

class_name Fight_Room

const can_return_to_room = false

var enemies = [] #current list of enemies so the player doesn't attack already dead enemies
var original_enemies = []#this is the list of enemies that was created at the start of the room
var turn_order_array = []
var turn_index
const turn_counter_time = 1
var turn_timer

func _init():
	pass

func _ready():
	turn_timer = Timer.new()
	turn_timer.name = "Leave Timer"
	get_parent().timer_group.add_child(turn_timer)
	turn_timer.set_wait_time(turn_counter_time)
	turn_timer.set_one_shot(false)
	turn_timer.connect("timeout", self, "turn_timer_tick")
	setup_battle()

func setup_battle():
	turn_index = 0
	randomize()
	var rand_num_enemies = int(rand_range(1, GlobalVars.current_stage+3))
	for i in rand_num_enemies:
		randomize()
		var chosen_enemy_list = GlobalVars.stage_enemies_dict[int(rand_range(1,GlobalVars.stage_enemies_dict[GlobalVars.current_stage].size()))]
		var chosen_enemy_type = chosen_enemy_list[int(rand_range(0,chosen_enemy_list.size()))]
		var new_enemy = Enemy.new(chosen_enemy_type)
		original_enemies.append(new_enemy)
		GlobalVars.main_node_ref.add_child(new_enemy)
		var spawn_pos = Vector2(rand_range(GlobalVars.main_node_ref.content_room_screen_loc.x - 20, GlobalVars.main_node_ref.content_room_screen_loc.x + 20), rand_range(GlobalVars.main_node_ref.content_room_screen_loc.y - 20, GlobalVars.main_node_ref.content_room_screen_loc.y + 20))
		new_enemy.position = spawn_pos #place the baddies at the right area in the room
		new_enemy.z_index = GlobalVars.main_node_ref.get_child_count()-1 #place baddies on the top layer
	enemies = original_enemies
	turn_timer.start()

func turn_timer_tick():
	process_turn(turn_order_array[turn_index])
	turn_index += 1
	if turn_index >= turn_order_array.size():
		turn_index = 0

func refresh_enemy_array():
	var temp_list = []
	for item in enemies:
		if item.is_dead == false:
			temp_list.append(item)
		pass
	enemies = temp_list
	pass

func process_turn(participant_node):
	participant_node.type_class.attack()
	if check_player_death():
		turn_timer.stop()
	check_enemies_death()
	refresh_enemy_array()
	#complete one turn

#check for deaths func's
func check_player_death():
	if GlobalVars.player_node_ref.is_dead:
		return true
	return false

func check_enemies_death():
	var all_enemies_dead = true
	for mob in enemies:
		if mob.is_dead == false:
			all_enemies_dead = false
	if all_enemies_dead:
		complete_battle()

func complete_battle():
	get_parent().complete_room()
