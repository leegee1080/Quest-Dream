extends Node2D

class_name Enemy

var type_enum


var type_class
export(Dictionary) var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"loot": 10
}
var is_dead = false

var ani_sprite
var hit_animation

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
	hit_animation = Hit_Color_Animation.new(ani_sprite, 0.1, 0.5)
	add_child(hit_animation)
	generate_enemy()

func _init(new_type, power_boost:int):
	if new_type == null:
		randomize()
		var rand_pick = int(rand_range(0, (Enemy_Enums.enemy_types_enum.size()-1)))
		type_enum = Enemy_Enums.enemy_types_dict.keys()[rand_pick]
		pass
	else:
		type_enum = new_type
	stat_dict["health"] = stat_dict["health"] * power_boost
	stat_dict["attack"] = stat_dict["attack"] * power_boost
	stat_dict["speed"] = stat_dict["speed"] * power_boost
	stat_dict["loot"] = stat_dict["loot"] * power_boost

func generate_enemy():
	if type_enum == null:
		type_enum = Enemy_Enums.enemy_types_enum.rat
	type_class = Enemy_Enums.enemy_types_dict.get(type_enum).new()
	print(type_class.name)
	stat_dict = type_class.stat_dict
	ani_sprite.set_frame(type_class.sprite_frame)

func process_turn(target):
	if is_dead == false:
		print("enemy " + str(type_class.name) + " turn")
#		type_class.attack() #needed to play special animations
		target.take_hit(stat_dict.speed)
	return
	
func take_hit(damage):
	type_class.hit()
	hit_animation.start_hit()
	stat_dict.health -= damage
	print(str(type_class.name) + " health left: " + str(stat_dict.health))
	if stat_dict.health <= 0:
		is_dead = true
		print(str(type_class.name) + " is dead")
	return
