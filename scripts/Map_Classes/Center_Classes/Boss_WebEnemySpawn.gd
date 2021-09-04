extends Node2D

class_name Boss_WebEnemySpawn

var sound

var ani_sprite
var item_frame = 94
const can_pick_up = false
var changes_direction = false
var spawn_timer

var minion = 1
var boss_avatar = 0

var action_array = [
	"spawn_avatar",
	"spawn_avatar",
	"spawn_avatar",
	"spawn_avatar",
	"spawn_avatar",
	"spawn_minion",
	"slow_player"
]

func _ready():
	randomize()
	action_array.shuffle()
	#play sound
	var parent_tile = get_parent()
	parent_tile.rotate_var = 0
	parent_tile.direction_enum = 0
	parent_tile.ani_sprite.set_frame(parent_tile.tile_theme_dict.get(parent_tile.theme_enum).get(0)[parent_tile.rotate_var])
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)
	
	if GlobalVars.boss_node_ref.map_avatar_node != null:
		action_array = ["spawn_minion","spawn_minion","spawn_minion", "slow_player"]
	
	if action_array[0] == "slow_player":
		return
	
	spawn_timer = Timer.new()
	spawn_timer.name = "Start Timer"
	add_child(spawn_timer)
	spawn_timer.add_to_group("timers")
	spawn_timer.set_wait_time(GlobalVars.main_node_ref.round_start_time)
	spawn_timer.set_one_shot(false)
	spawn_timer.connect("timeout", self, "spawn")
	spawn_timer.start()
	
	
	#slow player

func pick_up():
	#play sound
	finish_pickup_animation()
	return changes_direction

func finish_pickup_animation():
	get_parent().center_object_enum = 0
	queue_free()

func spawn():
	if action_array[0] == "spawn_avatar" and GlobalVars.boss_node_ref.map_avatar_node == null:
		var temp_enemy = Map_Boss.new(get_parent().position)
		GlobalVars.main_node_ref.add_child(temp_enemy)
		GlobalVars.boss_node_ref.map_avatar_node = temp_enemy
		temp_enemy.name = "boss_avatar"
		temp_enemy.walk_toggle()
		get_parent().center_object_enum = 0
		queue_free()
		return
	if action_array[0] == "spawn_avatar":
		var temp_enemy = Map_Enemy.new(minion, get_parent().position)
		GlobalVars.main_node_ref.add_child(temp_enemy)
		temp_enemy.name = "enemy"
		temp_enemy.walk_toggle()
		get_parent().center_object_enum = 0
		queue_free()
		return
