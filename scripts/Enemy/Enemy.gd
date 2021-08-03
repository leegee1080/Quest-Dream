extends Node2D

class_name Enemy

var ani_sprite

var type_enum
var type_class
var string_name

var ani_dict = {
	"walk": null,
	"injure": null,
	"death": null,
	"happy": null
}
var health = 1
var speed
var attack_power
var is_dead = false

func _ready():
	z_index = 12 #place baddies on the top layer
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
	generate_enemy()
	string_name = type_class.string_name
	setup_animations()

func _init(new_type):
	if new_type == null:
		randomize()
		var rand_pick = int(rand_range(0, (Enemy_Enums.enemy_types_enum.size()-1)))
		type_enum = Enemy_Enums.enemy_types_dict.keys()[rand_pick]
		pass
	else:
		type_enum = new_type

func setup_animations():
	for ani in type_class.special_animations_dict:
		var temp_ani_class
		if type_class.special_animations_dict[ani] == null:
			continue
		temp_ani_class = Animation_Enums.ani_dict[type_class.special_animations_dict[ani]].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class

func generate_enemy():
	if type_enum == null:
		type_enum = Enemy_Enums.enemy_types_enum.rat
	type_class = type_enum.new()
	ani_sprite.set_frame(type_class.sprite_frame)
	health = type_class.starting_health
	attack_power = type_class.damage

func take_hit(damage):
	if is_dead:
		return
	print("enemy took hit, damage: " + str(damage))
	ani_dict.injure.play_animation()
	if health <= 0:
		is_dead = true
		print(str(type_class.string_name) + " is dead")
