extends Node2D

class_name Enemy

var type_enum


var type_class
var string_name
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"loot": 10
}
var ani_dict = {
	"walk": null,
	"melee": null,
	"ranged": null,
	"magic": null,
	"injure": null,
	"death": null,
	"happy": null
}
var is_dead = false

var ani_sprite
#var hit_animation
#var death_animation

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
#	hit_animation = Hit_Color_Animation.new(ani_sprite)
#	add_child(hit_animation)
#	death_animation = Death_Animation.new(ani_sprite)
#	add_child(death_animation)
	generate_enemy()
	string_name = type_class.name
	setup_animations()

func _init(new_type, power_boost:int): #power boost is derived from the level of the room that the enemy was spawned in
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

func setup_animations():
	for ani in type_class.special_animations_dict:
		if type_class.special_animations_dict[ani] == null:
			continue
		var temp_ani_class
		temp_ani_class = type_class.special_animations_dict[ani].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class
		pass
	print(ani_dict)
	pass

func generate_enemy():
	if type_enum == null:
		type_enum = Enemy_Enums.enemy_types_enum.rat
	type_class = Enemy_Enums.enemy_types_dict.get(type_enum).new()
	merge_dict(stat_dict, type_class.stat_dict)
	ani_sprite.set_frame(type_class.sprite_frame)

func merge_dict(target, patch):
	for key in patch:
		if patch[key] == null:
			continue
		if patch[key] is Dictionary:
			continue
		var temp_val = target[key]
		target[key] = temp_val + patch[key]

func process_turn(target):
	if is_dead == false:
		print("enemy " + str(type_class.name) + " turn")
		ani_dict.melee.play_animation(target, stat_dict.attack)#needed to play special animations (melee, ranged, or magic)
#		target.take_hit(stat_dict.attack)
	return

func take_hit(damage):
	if is_dead:
		return
	ani_dict.injure.play_animation()
#	type_class.hit()
#	hit_animation.play_animation()
	stat_dict.health -= damage
	print(str(type_class.name) + " health left: " + str(stat_dict.health))
	if stat_dict.health <= 0:
		is_dead = true
		print(str(type_class.name) + " is dead")
		kill_enemy()
	return

func kill_enemy():
	ani_dict.injure.stop_animation()
	#pay the player exp points based on difficulty of the enemy
	#drop loot
	var temp_loot = null
	if type_class.is_boss:
		GlobalVars.player_node_ref.player_level += 20
		temp_loot = Loot.new(type_class.stat_dict.loot, Item_Enums.loot_filter_enum.boss)
	else:
		GlobalVars.player_node_ref.player_level += type_class.difficulty
		temp_loot = Loot.new(type_class.stat_dict.loot, Item_Enums.loot_filter_enum.normal)
	add_child(temp_loot)
	#give loot
	for item in temp_loot.item_list:
		print("Dropped: " + item.item_name)
		GlobalVars.temp_loot_pool.append(item)
		GlobalVars.main_node_ref.add_child(item)
		pass
	#death animation
	ani_dict.death.play_animation()
#	hit_animation.queue_free()
#	death_animation.play_animation()
	return
