extends Node2D

class_name Map_Boss

var ani_dict = {
	"walk": null,
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
var starting_pos
var is_dead = false
var health = 10

var playarea
var exit_tile_pos

var can_walk = false
var direction: Vector2 = Vector2(1,0)

var map_move_speed = .3
const walk_interval = 16
var walk_interval_count = walk_interval
var walk_timer_wait_time = 0.04
var walk_timer
const center_interval = 3
var center_interval_count = 0
var current_tile

var can_check_next_tile = true

var ani_sprite

func _ready():
	
	direction = walk_dir_dict.get(int(rand_range(0, walk_dir_dict.size())))
	health = type_class.starting_health
	walk_timer_wait_time = type_class.speed
	position = starting_pos
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.add_to_group("timers")
	walk_timer.set_wait_time(walk_timer_wait_time)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.connect("timeout", self, "walk")
	walk_timer.stop()
	
	GlobalVars.boss_node_ref.map_avatar_node = self
	
	setup_animations()

func _init(spawn_pos):
	starting_pos = spawn_pos
	type_class = GlobalVars.boss_node_ref
#	add_child(type_class)
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
	ani_sprite.set_frame(type_class.sprite_frame)
	playarea = GlobalVars.main_node_ref.max_starting_playarea

func setup_animations():
	for ani in type_class.special_animations_dict:
		var temp_ani_class
		if type_class.special_animations_dict[ani] == null:
			continue
		temp_ani_class = Animation_Enums.ani_dict[type_class.special_animations_dict[ani]].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class

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
		ani_dict.walk.play_animation()
		return

func walk():
	if is_dead:
		return
	check_player_current_tile()
	return

func check_player_current_tile():
	if position.distance_to(GlobalVars.player_node_ref.position) <= 5:
		var fight_class = Fight_Normal.new(self, position)
#		var fight_class = GlobalVars.player_node_ref.type_class.fight_class.new(self, position)
		GlobalVars.main_node_ref.add_child(fight_class)
		return

func leave():
	queue_free()
	pass

func take_hit(damage):
	if is_dead:
		return
	ani_dict.injure.play_animation()
	health -= damage
	print("enemy health: " + str(health))
	check_for_death()

func check_for_death():
	if health <= 0:
		is_dead = true
		walk_toggle()
		print("enemy dead")
		ani_dict.death.play_animation()
		GlobalVars.boss_node_ref.avatar_killed()
		queue_free()
	pass
