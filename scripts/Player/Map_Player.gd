extends Node2D

class_name Map_Player

var ani_dict = {
	"injure": null,
	"death": null,
	"happy": null
}
enum walk_dir{
	up,
	down,
	left,
	right
}
const walk_dir_dict = {
	walk_dir.up: Vector2(0,-1),
	walk_dir.down: Vector2(0,1),
	walk_dir.left: Vector2(-1,0),
	walk_dir.right: Vector2(1,0)
}
const walk_ani_pos_list = [
	[Vector2(0,0), 0],
	[Vector2(-1,-2), 0.1],
	[Vector2(0,0), 0],
	[Vector2(1,-2), -0.1]
]

#var type_enum
var type_class
var is_dead = false

var playarea
var exit_tile_pos

var can_walk = false
var direction: Vector2 = Vector2(0,0)

var map_move_speed = .3
var turn_around_damage = 1
var outer_wall_damage = 1
const walk_interval = 16
var walk_interval_count = walk_interval
var walk_timer_wait_time = GlobalVars.player_type_class_storage.speed
var walk_timer
var injure_timer
const center_interval = 3
var center_interval_count = 2
var current_tile

var can_check_next_tile = true

var ani_sprite

#var map_action_queued = false

func _ready():
	add_to_group("fast_forward_grp")
	if GlobalVars.main_node_ref.is_fast_forwarded:
		walk_timer_wait_time = GlobalVars.player_type_class_storage.speed / 10
	
	type_class = GlobalVars.player_type_class_storage
	turn_around_damage = type_class.gimmick_class.bool_dict["turn_around_damage"]
	outer_wall_damage = type_class.gimmick_class.bool_dict["outer_wall_damage"]
	
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.add_to_group("timers")
	walk_timer.set_wait_time(walk_timer_wait_time)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.connect("timeout", self, "walk")
	walk_timer.stop()
	
	injure_timer = Timer.new()
	add_child(injure_timer)
	injure_timer.add_to_group("timers")
	injure_timer.set_wait_time(0.5)
	injure_timer.set_one_shot(true)
	injure_timer.connect("timeout", self, "walk_toggle")
	injure_timer.stop()
	setup_animations()

func _init():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	ani_sprite.set_frame(GlobalVars.player_type_class_storage.sprite_frame)

func setup_animations():
	for ani in GlobalVars.player_type_class_storage.special_animations_dict:
		var temp_ani_class
		if GlobalVars.player_type_class_storage.special_animations_dict[ani] == null:
			continue
		temp_ani_class = Animation_Enums.ani_dict[GlobalVars.player_type_class_storage.special_animations_dict[ani]].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class

func map_action():
	if GlobalVars.player_consumable_amount > type_class.action_cost and can_walk:
		if type_class.action_class.action():
				GlobalVars.change_consume(-type_class.action_cost)
	pass

#func map_action():
#	for loc in GlobalVars.main_node_ref.clickable_coords_list:
#			var x_test = loc[0]
#			var y_test = loc[1]
#			if position[0] >= x_test[0] and position[0] < x_test[1] and position[1] >= y_test[0] and position[1] < y_test[1]:
#				if GlobalVars.main_node_ref.tile_dict.get(loc[2]) != null and (GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_player_built or GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_terminal_tile):
#					return
#				if GlobalVars.main_node_ref.tile_dict.get(loc[2]) != null:
#					GlobalVars.main_node_ref.tile_dict.get(loc[2]).is_locked = false
#					GlobalVars.main_node_ref.tile_dict.get(loc[2]).delete_tile()
#					GlobalVars.main_node_ref.tile_dict[loc[2]] = null
#				#assign the new tile node to the correct dictionary entry
#				var new_tile = Tile.new(GlobalVars.player_type_class_storage.tile_direction, GlobalVars.current_theme, GlobalVars.player_type_class_storage.tile_center, 0, -1)
#				new_tile.is_player_built = true
#				GlobalVars.main_node_ref.tile_dict[loc[2]] = new_tile
#				GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(new_tile)
#				GlobalVars.main_node_ref.tile_dict[loc[2]].place_tile(loc[3])
#				GlobalVars.main_node_ref.tile_dict[loc[2]].name = "built_tile " + str(loc[2])
#
#				GlobalVars.player_consumable_amount -= GlobalVars.player_type_class_storage.action_cost
#				get_tree().call_group("UI_Player_Info", "update_consumable")
#				check_for_death()
#				map_action_queued = false
#	print("action")

func change_dir(new_dir):
	if new_dir >= 0 and new_dir < walk_dir.size():
		direction = walk_dir_dict.get(new_dir)
		return
	direction = Vector2(0,0)
	return

func fast_forward():
	walk_timer.set_wait_time(GlobalVars.player_type_class_storage.speed / 10)
	pass

func walk_toggle():
	if is_dead:
		can_walk = false
		walk_timer.stop()
		ani_dict.walk.stop_animation()
		ani_sprite.position = Vector2.ZERO
		ani_sprite.rotation = 0
		return
	if can_walk:
		can_walk = false
		walk_timer.stop()
		ani_dict.walk.stop_animation()
		ani_sprite.position = Vector2.ZERO
		ani_sprite.rotation = 0
		return
	elif !can_walk:
		can_walk = true
		walk_timer.start()
		ani_dict.happy.stop_animation()
		ani_dict.walk.play_animation()
		return

func walk():
	if is_dead:
		ani_dict.walk.stop_animation()
		return
	translate(direction*map_move_speed)
	walk_interval_count -= map_move_speed
	if center_interval_count == 1:
		if check_map_edge() == true:
			return
		check_tile()
	if center_interval_count <= 0:
		center_interval_count = center_interval
#		print(walk_interval_count) = 15.7
		check_center_tile()
	if walk_interval_count <= 0:
		walk_interval_count = walk_interval
		center_interval_count -= 1
		can_check_next_tile = true
	return

func check_map_edge():
	var x_test = [playarea[0][0],playarea[1][0]]
	var y_test = [playarea[0][1],playarea[1][1]]
	if (position.x < x_test[0] or position.x > x_test[1]) or (position.y < y_test[0] or position.y > y_test[1]):
		if check_dist_exit():
			ani_dict.happy.play_animation()
			get_parent().win_round()
			return true
		turn_around(outer_wall_damage)
		return true
	return false

func check_dist_exit():
	if position.distance_to(exit_tile_pos) <= 16:
		return true
	return false

func check_tile():
	if is_dead:
		return
	var tile_coords_list = get_parent().clickable_coords_list
	var current_tile_dict = get_parent().tile_dict
#	if map_action_queued and can_check_next_tile:
#		can_check_next_tile = false
#		return
	
	for loc in tile_coords_list:
				var x_test = loc[0]
				var y_test = loc[1]
				if position.x >= x_test[0] and position.x < x_test[1] and position.y >= y_test[0] and position.y < y_test[1]:
					if current_tile_dict.get(loc[2]) != null:
						if current_tile_dict.get(loc[2]).is_impass_tile == true and can_check_next_tile:
							can_check_next_tile = false
							turn_around(turn_around_damage)
							return
						if current_tile_dict.get(loc[2]).rot_value_changer(direction, GlobalVars.player_type_class_storage.t_turn_right) == null and can_check_next_tile:
							can_check_next_tile = false
							turn_around(turn_around_damage)
							return
						if current_tile_dict.get(loc[2]).is_locked != true:
							current_tile_dict.get(loc[2]).lock_tile()
						current_tile = current_tile_dict.get(loc[2])
						return
					elif current_tile_dict.get(loc[2]) == null and can_check_next_tile:
						can_check_next_tile = false
						turn_around(turn_around_damage)
						return
	return

func check_center_tile():
	if current_tile == null:
		return
	position = current_tile.position #to make sure the grid stays aligned
	if current_tile.center_subtile == null:
		direction = current_tile.rot_value_changer(direction, GlobalVars.player_type_class_storage.t_turn_right)
		return
	if can_walk:
		walk_toggle()
		injure_timer.start()
		pass
	if current_tile.center_subtile.can_pick_up == true:
		if current_tile.center_subtile.pick_up() == true:
			return
		if current_tile.rot_value_changer(direction, GlobalVars.player_type_class_storage.t_turn_right) == null:
			print("null rot value on tile: " + current_tile.name)
			return
		direction = current_tile.rot_value_changer(direction, GlobalVars.player_type_class_storage.t_turn_right)
		return
	return

func turn_around(penalty):
	if penalty == null:
		penalty = 0
	direction = (direction *-1) #turn the player around
	center_interval_count = 2
	take_hit(penalty)
	return

func take_hit(damage):
	if is_dead:
		return
	if can_walk:
		walk_toggle()
		injure_timer.start()
		pass
	GlobalVars.change_consume(damage * -1)
#	GlobalVars.player_consumable_amount -= damage
#	get_tree().call_group("UI_Player_Info", "update_consumable")
	check_for_death()
	ani_dict.injure.play_animation()
	print("Player health: "+ str(GlobalVars.player_consumable_amount))

func check_for_death():
	if GlobalVars.player_consumable_amount <= 0:
		is_dead = true
		print("player dead")
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
	pass
