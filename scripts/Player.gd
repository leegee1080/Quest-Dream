extends Node2D

class_name Player

enum player_types_enum{
	soldier,
	valkyrie,
	ranger,
	executioner,
	berserker,
	knight,
	assassin,
	wizard,
	traveler,
	necromancer
}
const player_types_dict = {
	player_types_enum.soldier: Soldier,
	player_types_enum.valkyrie: Valkyrie,
	player_types_enum.ranger: Ranger,
	player_types_enum.executioner: Executioner,
	player_types_enum.berserker: Berserker,
	player_types_enum.knight: Knight,
	player_types_enum.assassin: Assassin,
	player_types_enum.wizard: Wizard,
	player_types_enum.traveler: Traveler,
	player_types_enum.necromancer: Necromancer
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

var player_level #unused right now

var type_enum
var type_class
var player_stat_dict = {"attack": 10, "speed": 10, "magic": 10, "equipment": {}}
var vit_dict = {"health": 100, "food": 100}
var class_stat_dict
var is_dead = false
var level
var difficulty


var playarea
var exit_tile_pos

var can_walk = false
var direction = Vector2(0,0)
######################################################################suggestion!!!!!!!!!!!!!!!!!!!! make the movement speed tied to the combat speed
var speed = .3
const walk_interval = 16
var walk_interval_count = walk_interval
const walk_timer_wait_time = 0.04
var walk_timer
const center_interval = 3
var center_interval_count = 2
var current_tile

var ani_sprite
var walk_animation
var hit_animation


func _ready():
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.set_wait_time(walk_timer_wait_time)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.connect("timeout", self, "walk")
	walk_timer.stop()
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	walk_animation = Walking_Animation.new(ani_sprite, 0.1)
	hit_animation = Hit_Color_Animation.new(ani_sprite, 0.1, 0.5)
	add_child(walk_animation)
	add_child(hit_animation)
	generate_player()
#	stat_dict["food"] = 10
#	print(stat_dict.food)
	return

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
		type_enum = player_types_enum.soldier
		return
	type_enum = new_type
	level = set_level
	difficulty = set_difficulty
	type_class = player_types_dict.get(type_enum).new()
	class_stat_dict = type_class.stat_dict
	player_stat_dict.attack = type_class.stat_dict.get("attack") + player_stat_dict.attack
	player_stat_dict.speed = type_class.stat_dict.speed + player_stat_dict.speed
	vit_dict.health = type_class.stat_dict.health + vit_dict.health
	player_stat_dict.magic = type_class.stat_dict.magic + player_stat_dict.magic
	merge_dir(player_stat_dict.equipment, type_class.stat_dict.equipment)
	merge_dir(player_stat_dict.equipment, set_equipment)
	return

func merge_dir(target, patch):
	for key in patch:
		target[key] = patch[key]

func change_food(amt):
	vit_dict.food += amt
	return

func check_food_level():
	if vit_dict.food <= 0:
		print("ded by food loss")
		walk_toggle()
		is_dead = true
		print("Round End")
	return

func change_dir(new_dir):
	if new_dir >= 0 and new_dir < walk_dir.size():
		direction = walk_dir_dict.get(new_dir)
		return
	direction = Vector2(0,0)

func walk_toggle():
	if is_dead:
		return
	if can_walk:
		can_walk = false
		walk_timer.stop()
		walk_animation.stop_walk()
		ani_sprite.position = Vector2.ZERO
		ani_sprite.rotation = 0
		return
	elif !can_walk:
		can_walk = true
		walk_timer.start()
		walk_animation.start_walk()
		return

func walk():
	translate(direction*speed)
	walk_interval_count -= speed
	change_food(walk_timer_wait_time * -1)
	check_food_level()
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
			walk_toggle()
			print("Round End")
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
#						current_tile_dict.get(loc[2]).is_locked = true
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
#	print("direction: " + str(direction))
	if current_tile.center_subtile == null:
		if current_tile.is_boss_tile == true:
			print("boss battle")
#			walk_toggle()
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

func generate_player():
	print(type_class.name)
	ani_sprite.set_frame(type_class.sprite_frame)

func turn_around():
	direction = (direction *-1) #turn the player around
	center_interval_count = 2
	return

func heal_player(new_health):
	vit_dict.health += new_health

func process_turn(target):
	if is_dead == false:
		print("player turn")
		target.take_hit(player_stat_dict.attack)
#		type_class.special() #needed to play special animations

func take_hit(damage):
	type_class.take_hit()
	hit_animation.start_hit()
	vit_dict.health -= damage
	if vit_dict.health <= 0:
		print("player dead")
		is_dead = true
	print("Player health: "+ str(vit_dict.health))
