extends Node2D

class_name Bad_EnemySpawn

var sound

var ani_sprite
var item_frame = 79
const can_pick_up = false
var changes_direction = false
var spawn_timer

func _ready():
	var parent_tile = get_parent()
	parent_tile.rotate_var = 0
	parent_tile.direction_enum = 0
	parent_tile.ani_sprite.set_frame(parent_tile.tile_theme_dict.get(parent_tile.theme_enum).get(0)[parent_tile.rotate_var])
	
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/item_frames.tres"))
	ani_sprite.set_frame(item_frame)
	add_child(ani_sprite)
	
	spawn_timer = Timer.new()
	spawn_timer.name = "Start Timer"
	add_child(spawn_timer)
	spawn_timer.add_to_group("timers")
	spawn_timer.set_wait_time(GlobalVars.main_node_ref.round_start_time)
	spawn_timer.set_one_shot(false)
	spawn_timer.connect("timeout", self, "spawn")
	spawn_timer.start()

func spawn():
	#Enemy_Enums.enemy_types_enum.goblin = 1
	var temp_enemy = Map_Enemy.new(1, get_parent().position)
	GlobalVars.main_node_ref.add_child(temp_enemy)
	temp_enemy.name = "enemy"
	temp_enemy.walk_toggle()
	queue_free()
	pass
