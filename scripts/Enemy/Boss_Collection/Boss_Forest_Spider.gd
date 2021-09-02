extends Node2D

class_name Boss_Forest_Spider

var string_name = "Giant Spider"
var sprite_frame = 15

const special_animations_dict = {
	"walk": "wiggle_in_place",
	"death": "death_flip_red",
	"injure": "hit_color_change",
	"happy": "happy_flip"
}

#map vars
var t_turn_right = false
var death_sound = "bossdeath1"

#battle vars
var damage = 1
var starting_health = 1
var boss_health = 5
var speed = 0.04
var reward = 10

var map_avatar_node
var web_centertile = 13
var num_webtiles = 5

var web_setup_timer = Timer.new()
var battle_phase_timer = Timer.new()
var cleanup_timer = Timer.new()

func _ready():
	setup_timer(web_setup_timer, 0.5, false, "place_tile")
	setup_timer(battle_phase_timer, 30.0, true, "finish_battle")
	setup_timer(cleanup_timer, 5.0, true, "cleanup")
	setup_web()
	pass

func setup_web():
	randomize()
	num_webtiles = int(rand_range(3,8))
	web_setup_timer.start()
	battle_phase_timer.start()
	pass

func place_tile():
	var picked_coord
	var tile
	if num_webtiles > 1:
		while num_webtiles > 0:
			picked_coord = GlobalVars.main_node_ref.clickable_coords_list[int(rand_range(0, GlobalVars.main_node_ref.clickable_coords_list.size()))]
			randomize()
			GlobalVars.tile_path_type_chance_array.shuffle()
			tile = Tile.new(GlobalVars.tile_path_type_chance_array[0], GlobalVars.current_theme, web_centertile, 0, -1)
			tile.name = "Web Tile: " + str(num_webtiles)
			GlobalVars.main_node_ref.tile_dict[picked_coord[2]] = tile
			GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(tile)
			tile.place_tile(picked_coord[3])
			tile.lock_tile()
			num_webtiles -= 1
	else:
		web_setup_timer.stop()
	pass

func avatar_killed():
	boss_health -= 1
	GlobalVars.call_func_all_minions("leave")
	cleanup_timer.start()
	pass

func finish_battle():
	cleanup_timer.start()
	map_avatar_node.leave()
	GlobalVars.call_func_all_minions("leave")
	pass

func cleanup():
	setup_web()
	pass

func setup_timer(timer_var, wait_time, is_oneshot, func_name):
	timer_var.add_to_group("timers")
	timer_var.set_wait_time(wait_time)
	timer_var.set_one_shot(is_oneshot) # Make sure it loops
	timer_var.connect("timeout", self, func_name)
	timer_var.stop()
	add_child(timer_var)
	pass
