extends Node2D

class_name Room_Player

var ani_dict = {
	"walk": null,
	"injure": null,
	"death": null,
	"happy": null
}

var type_class
var health
var is_dead = false
var level_hash = []

var ani_sprite

#battle vars
var attack_class
var defend_class
var turn_class

func _ready():
	z_index = 12 #make sure the player sprite is on top
	type_class = GlobalVars.player_node_ref.type_class
	health = GlobalVars.player_node_ref.consumable_amt
	ani_dict = GlobalVars.player_node_ref.ani_dict
	level_hash = GlobalVars.player_node_ref.level_hash
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	ani_sprite.set_frame(type_class.sprite_frame)
	setup_animations()

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
	pass

func heal_player(new_health):
	health += new_health
	print("Player now has "+ str(health) + " health left.")

func take_hit(damage):
	get_tree().call_group("UI_Player_Info", "update_consumable")
	ani_dict.injure.play_animation()
	health -= damage
	if health <= 0:
		print("player dead")
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
		is_dead = true
	print("Player health: "+ str(health))

func process_turn(target_list):
	turn_class.process_turn(target_list)
	pass

func attack(target_node):
	attack_class.attack(target_node)

func defend(damage):
	defend_class.defend(damage)
