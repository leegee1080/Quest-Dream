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
#battle vars
var battle_dict = {
	"attack": Animation_Enums.attack_dict.tackle,
	"defend" : Animation_Enums.defend_dict.weak,
	"turn" : Animation_Enums.turn_dict.simple_attack
}
var health = 1
var speed
var attack_power
var is_dead = false
var lane_index = 2 #this stores a number (0-4) that indicates the lane the player is in for battle

var turn_timer
var turn_speed

var current_target_list


func _ready():
	z_index = 12 #place baddies on the top layer
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
	generate_enemy()
	string_name = type_class.string_name
	setup_animations()
	turn_timer.start()

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
	battle_dict.attack = Animation_Enums.attack_dict[type_class.special_moves_dict["attack"]].new(ani_sprite)
	battle_dict.defend = Animation_Enums.defend_dict[type_class.special_moves_dict["defend"]].new(ani_sprite)
	battle_dict.turn = Animation_Enums.turn_dict[type_class.special_moves_dict["turn"]].new(ani_sprite)
	add_child(battle_dict.attack)
	add_child(battle_dict.defend)
	add_child(battle_dict.turn)

func generate_enemy():
	if type_enum == null:
		type_enum = Enemy_Enums.enemy_types_enum.rat
	type_class = type_enum.new()
	ani_sprite.set_frame(type_class.sprite_frame)
	health = type_class.starting_health
	attack_power = type_class.damage
	turn_timer = Timer.new()
	turn_speed = type_class.speed
	add_child(turn_timer)
	turn_timer.add_to_group("timers")
	turn_timer.set_wait_time(turn_speed)
	turn_timer.set_one_shot(false)
	turn_timer.connect("timeout", self, "process_turn")

func process_turn():
	if is_dead == false:
		print("enemy " + str(type_class.string_name) + " turn")
		battle_dict.turn.process_turn()

func attack():
	print("enemy " + str(type_class.string_name) + " attack")
	battle_dict.attack.attack(lane_index, attack_power)

func take_hit(damage):
	if is_dead:
		return
	print("enemy took hit, damage: " + str(damage))
	ani_dict.injure.play_animation()
	battle_dict.defend.defend(damage)
	if health <= 0:
		if !type_class.is_minion:
			GlobalVars.main_node_ref.room_screen.complete_room()
		turn_timer.stop()
		is_dead = true
		print(str(type_class.string_name) + " is dead")
		kill_enemy()

func kill_enemy():
	ani_dict.injure.stop_animation()
	ani_dict.death.play_animation()
