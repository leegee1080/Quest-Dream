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

export(player_types_enum) var type_enum
var type_class
export(Dictionary) var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"equipment": {}
}
var level
var difficulty

var can_walk = false
var direction = Vector2(0,0)
var speed = .1
var walk_timer
var current_tile

var ani_sprite

func _ready():
	walk_timer = Timer.new()
	add_child(walk_timer)
	walk_timer.set_wait_time(0.1)
	walk_timer.set_one_shot(false) # Make sure it loops
	walk_timer.start()
	walk_timer.connect("timeout", self, "walk")
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	generate_player()
	return

func _init(new_type, set_level: int, set_difficulty: int, set_equipment: Dictionary):
	if new_type == null:
		type_enum = player_types_enum.soldier
		return
	type_enum = new_type
	level = set_level
	difficulty = set_difficulty
	stat_dict["equipment"] = set_equipment
	

func change_dir(new_dir):
	if new_dir >= 0 and new_dir < walk_dir.size():
		direction = walk_dir_dict.get(new_dir)
		return
	direction = Vector2(0,0)

func walk_toggle():
	if can_walk:
		can_walk = false
		walk_timer.stop()
		return
	elif !can_walk:
		can_walk = true
		walk_timer.start()
		return

func walk():
	translate(direction*speed)
	return

func generate_player():
	if type_enum == null:
		type_enum = player_types_enum.soldier
	type_class = player_types_dict.get(type_enum).new()
	print(type_class.name)
	stat_dict = type_class.stat_dict
	ani_sprite.set_frame(type_class.sprite_frame)

func process_turn():
	type_class.special()
	return

func take_hit():
	type_class.hit()
	return
