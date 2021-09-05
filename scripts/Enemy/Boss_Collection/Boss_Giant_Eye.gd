extends Node2D

class_name Boss_Giant_Eye

var string_name = "Giant Eyeball"
var sprite_frame = 16

const special_animations_dict = {
	"walk": "float_walk",
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
var boss_health = 3
var speed = 0.04
var reward = 10

var map_avatar_node

var spawn_coords = [
	[Vector2(3,5), Vector2(0,-1)],
	[Vector2(3,1), Vector2(0,1)],
	[Vector2(5,3), Vector2(-1,0)],
	[Vector2(1,3), Vector2(1,0)]
]
var beam_array = []
var beam_iteration
var impass_tile = 10

var eyebeam_setup_timer = Timer.new()
var battle_phase_timer = Timer.new()
var cleanup_timer = Timer.new()

func _ready():
	setup_timer(eyebeam_setup_timer, 0.20, false, "place_impass")
	setup_timer(battle_phase_timer, 30.0, true, "finish_battle")
	setup_timer(cleanup_timer, 1.0, true, "cleanup")
	
	spawn_avatar()
	pass

func spawn_avatar():
	var tile
	var picked_coord
	
	while true:
		randomize()
		spawn_coords.shuffle()
		picked_coord = GlobalVars.main_node_ref.vector_index_coords_dict[spawn_coords[0][0]]
		var picked_tile_node = GlobalVars.main_node_ref.tile_dict[picked_coord[3]]
		if picked_tile_node == null:
			break
		if picked_tile_node != null:
			if picked_tile_node == GlobalVars.player_node_ref.current_tile:
				continue
			picked_tile_node.queue_free()
			break
	tile = Tile.new(0, GlobalVars.current_theme, 0, 0, -1)
	tile.name = "Avatar Tile"
	GlobalVars.main_node_ref.tile_dict[picked_coord[3]] = tile
	GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(tile)
	tile.place_tile(picked_coord[2])
	tile.tile_loc_clickable_area = spawn_coords[0]
	tile.lock_tile()
	var temp_enemy = Map_Boss.new(picked_coord[2])
	GlobalVars.main_node_ref.add_child(temp_enemy)
	map_avatar_node = temp_enemy
	temp_enemy.name = "boss_avatar"
	temp_enemy.walk_toggle()
	eye_beam_array()
	beam_iteration = 0
	eyebeam_setup_timer.start()
	pass

func eye_beam_array():
	beam_array = []
	var tiles = 1
	while tiles < 5:
		beam_array.append(spawn_coords[0][0]+(spawn_coords[0][1]*tiles))
		tiles += 1
	pass

func place_impass():
	var tile
	var picked_coord
	
	picked_coord = GlobalVars.main_node_ref.vector_index_coords_dict[beam_array[beam_iteration]]
	var picked_tile_node = GlobalVars.main_node_ref.tile_dict[picked_coord[3]]
	if picked_tile_node != null:
		if picked_tile_node == GlobalVars.player_node_ref.current_tile:
			return
		picked_tile_node.queue_free()
		pass
	tile = Tile.new(4, GlobalVars.current_theme, 10, 0, -1)
	tile.name = "Eye Beam Tile"
	GlobalVars.main_node_ref.tile_dict[picked_coord[3]] = tile
	GlobalVars.main_node_ref.ingame_tilegroup_Node.add_child(tile)
	tile.place_tile(picked_coord[2])
	tile.tile_loc_clickable_area = spawn_coords[0]
	tile.lock_tile()
	beam_iteration += 1
	if beam_iteration > 3:
		eyebeam_setup_timer.stop()
		battle_phase_timer.start()
		return
	pass

func avatar_killed():
	print("avatar killed")
	boss_health -= 1
	if boss_health <= 0:
		print("boss killed")
		GlobalVars.audio_player.play(death_sound)
		GlobalVars.main_node_ref.win_round()
	if map_avatar_node != null:
		map_avatar_node.leave()
	cleanup_timer.start()
	pass

func finish_battle():
	cleanup_timer.start()
	if map_avatar_node != null:
		map_avatar_node.leave()
	pass

func cleanup():
	spawn_avatar()
	pass

func setup_timer(timer_var, wait_time, is_oneshot, func_name):
	timer_var.add_to_group("timers")
	timer_var.set_wait_time(wait_time)
	timer_var.set_one_shot(is_oneshot) # Make sure it loops
	timer_var.connect("timeout", self, func_name)
	timer_var.stop()
	add_child(timer_var)
	pass
