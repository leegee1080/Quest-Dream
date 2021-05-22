extends Node2D

class_name Player

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

var player_level #unused right now

var type_enum
var type_class
var player_stat_dict = {"attack": 10, "speed": 10, "magic": 10, "health": 100, "equipment": {}}
var class_stat_dict
var is_dead = false
var level
var difficulty


var playarea
var exit_tile_pos

var can_walk = false
var direction = Vector2(0,0)
######################################################################suggestion!!!!!!!!!!!!!!!!!!!! make the movement speed tied to the combat speed
var map_move_speed = .3
const walk_interval = 16
var walk_interval_count = walk_interval
const walk_timer_wait_time = 0.04
var walk_timer
const center_interval = 3
var center_interval_count = 2
var current_tile

var ani_sprite


func _ready():
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.add_to_group("timers")
	walk_timer.set_wait_time(walk_timer_wait_time)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.connect("timeout", self, "walk")
	walk_timer.stop()
	add_child(type_class)

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
		type_enum = Player_Enums.player_types_enum.soldier
		return
	type_enum = new_type
	level = set_level
	difficulty = set_difficulty
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	type_class = Player_Enums.player_types_dict.get(type_enum).new(ani_sprite)
	class_stat_dict = type_class.stat_dict
	ani_sprite.set_frame(type_class.sprite_frame)
	merge_dir(player_stat_dict, type_class.stat_dict)
	merge_dir(player_stat_dict.equipment, type_class.stat_dict.equipment)
	merge_dir(player_stat_dict.equipment, set_equipment)

func merge_dir(target, patch):
	for key in patch:
		if patch[key] is Dictionary:
			continue
		var temp_val = target[key]
		target[key] = temp_val + patch[key]
	return

func change_dir(new_dir):
	if new_dir >= 0 and new_dir < walk_dir.size():
		direction = walk_dir_dict.get(new_dir)
		return
	direction = Vector2(0,0)
	return

func walk_toggle():
	if is_dead:
		return
	if can_walk:
		can_walk = false
		walk_timer.stop()
		type_class.walk_animation.stop_walk()
		ani_sprite.position = Vector2.ZERO
		ani_sprite.rotation = 0
		return
	elif !can_walk:
		can_walk = true
		walk_timer.start()
		type_class.walk_animation.start_walk()
		return

func walk():
	translate(direction*map_move_speed)
	walk_interval_count -= map_move_speed
	if center_interval_count == 1:
		check_map_edge()
		check_tile()
	if center_interval_count <= 0:
		center_interval_count = center_interval
		check_center_tile()
	if walk_interval_count <= 0:
		walk_interval_count = walk_interval
		center_interval_count -= 1
	return

func check_map_edge():
	var x_test = [playarea[0][0],playarea[1][0]]
	var y_test = [playarea[0][1],playarea[1][1]]
#	print(position)
#	print(x_test)
#	print(y_test)
	if (position.x < x_test[0] or position.x > x_test[1]) or (position.y < y_test[0] or position.y > y_test[1]):
		if check_dist_exit():
			get_parent().win_round()
			return
		turn_around()
	return

func check_dist_exit():
	if position.distance_to(exit_tile_pos) <= 16:
		return true
	return false

func check_tile():
	var tile_coords_list = get_parent().clickable_coords_list
	var current_tile_dict = get_parent().tile_dict
	for loc in tile_coords_list:
				var x_test = loc[0]
				var y_test = loc[1]
				if position.x >= x_test[0] and position.x < x_test[1] and position.y >= y_test[0] and position.y < y_test[1]:
					if current_tile_dict.get(loc[2]) != null:
						if current_tile_dict.get(loc[2]).is_impass_tile == true:
							turn_around()
							return
						if current_tile_dict.get(loc[2]).rot_value_changer(direction) == null:
							turn_around()
							return
						if current_tile_dict.get(loc[2]).is_locked != true:
							current_tile_dict.get(loc[2]).lock_tile()
						current_tile = current_tile_dict.get(loc[2])
						return
					elif current_tile_dict.get(loc[2]) == null:
						turn_around()
						return
	return

func check_center_tile():
	if current_tile == null:
		return
	position = current_tile.position #to make sure the grid stays aligned
	direction = current_tile.rot_value_changer(direction)
	if current_tile.center_subtile == null:
		if current_tile.is_boss_tile == true:
			print("boss battle")
			return
#		print("no center tile " + 
#		"|at:" + current_tile.name + 
#		"|direction:" + Tile_Enums.tile_directions_enum.keys()[current_tile.direction_enum] + 
#		"|rotation:" + str(current_tile.rotate_var)
#		)
		return
#	print(
#		"|level:" + str(current_tile.center_subtile.subtile_level) + 
#		"|centertile:" + Tile_Enums.center_type_enum.keys()[current_tile.center_subtile.subtile_type_enum] + 
#		"|at:" + current_tile.name + 
#		"|direction:" + Tile_Enums.tile_directions_enum.keys()[current_tile.direction_enum] +
#		"|rotation:" + str(current_tile.rotate_var)
#		)
	walk_toggle()
	get_parent().open_room(current_tile)
	return

func turn_around():
	direction = (direction *-1) #turn the player around
	center_interval_count = 2
	take_hit(10)
	return

func heal_player(new_health):
	player_stat_dict.health += new_health
	print("Player now has "+ str(player_stat_dict.health) + " health left.")

func process_turn(target):
	if is_dead == false:
		target.take_hit(player_stat_dict.attack)
#		type_class.melee() #needed to play special animations (melee, ranged, or magic)

func take_hit(damage):
	type_class.take_hit()
	player_stat_dict.health -= damage
	if player_stat_dict.health <= 0:
		print("player dead")
		get_parent().lose_round()
		type_class.die()
		is_dead = true
	print("Player health: "+ str(player_stat_dict.health))
