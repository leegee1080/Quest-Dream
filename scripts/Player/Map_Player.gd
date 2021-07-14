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
const walk_interval = 16
var walk_interval_count = walk_interval
const walk_timer_wait_time = 0.04
var walk_timer
const center_interval = 3
var center_interval_count = 2
var current_tile
var ani_sprite

func _ready():
	type_class = GlobalVars.player_type_class_storage
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.add_to_group("timers")
	walk_timer.set_wait_time(walk_timer_wait_time)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.connect("timeout", self, "walk")
	walk_timer.stop()
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
		ani_dict.walk.stop_animation()
		ani_sprite.position = Vector2.ZERO
		ani_sprite.rotation = 0
		return
	elif !can_walk:
		can_walk = true
		walk_timer.start()
		ani_dict.walk.play_animation()
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
#			get_parent().open_boss_room()
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
		return
	if current_tile.center_object_enum == Tile_Enums.center_type_enum.treasure or current_tile.center_object_enum == Tile_Enums.center_type_enum.consumable:
		current_tile.center_subtile.pick_up()
		return
	return

func turn_around():
	direction = (direction *-1) #turn the player around
	center_interval_count = 2
	take_hit(1)
	return

func take_hit(damage):
	if is_dead:
		return
	get_tree().call_group("UI_Player_Info", "update_consumable")
	ani_dict.injure.play_animation()
	GlobalVars.player_consumable_amount -= damage
	if GlobalVars.player_consumable_amount <= 0:
		print("player dead")
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
		is_dead = true
	print("Player health: "+ str(GlobalVars.player_consumable_amount))
