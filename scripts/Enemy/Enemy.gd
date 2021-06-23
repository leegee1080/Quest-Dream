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
	"attack": Animation_Enums.attack_dict.Tackle,
	"defend" : Animation_Enums.defend_dict.Weak,
	"turn" : Animation_Enums.turn_dict.Simple_Attack
}
var health
var speed
var is_dead = false

var current_target_list


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
	for ani in ani_dict:
		if type_class.special_animations_dict[ani] == null:
			continue
		var temp_ani_class
		temp_ani_class = type_class.special_animations_dict[ani].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class
		pass
	pass
	battle_dict.attack = type_class.special_moves_dict.attack.new(ani_dict)
	add_child(battle_dict.attack)
	battle_dict.dodge = type_class.special_moves_dict.dodge.new(ani_dict)
	add_child(battle_dict.dodge)

func generate_enemy():
	if type_enum == null:
		type_enum = Enemy_Enums.enemy_types_enum.rat
	type_class = type_enum.new()
	ani_sprite.set_frame(type_class.sprite_frame)

func process_turn():
	if is_dead == false:
		print("enemy " + str(type_class.name) + " turn")
		battle_dict.turn.process_turn(GlobalVars.room_player_node_ref.players_team)

func take_hit(damage):
	if is_dead:
		return
	ani_dict.injure.play_animation()
	battle_dict.defend.defend(damage)
	if health <= 0:
		is_dead = true
		print(str(type_class.name) + " is dead")
		kill_enemy()

func kill_enemy():
	ani_dict.injure.stop_animation()
	ani_dict.death.play_animation()
