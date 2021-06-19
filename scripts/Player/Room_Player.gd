extends Node2D

class_name Room_Player

var ani_dict = {
	"walk": null,
	"injure": null,
	"death": null,
	"happy": null
}
var battle_dict = {
	"attack": null,
	"dodge" : null
}

var ani_sprite
var is_dead = false


var type_class
var health

var max_dodge_charges
var current_dodge_charges = 0
var dodge_charge_timer

var max_attack_charges
var current_attack_charges = 0
var attack_charge_timer

var attack_class
var dodge_class

var current_player_state
var previous_player_state
enum game_state{
	setup,
	ready,
	attack,
	dodge,
	dead,
	win
}

func _ready():
	GlobalVars.room_player_node_ref = self
	current_player_state = game_state.setup
	z_index = 12 #make sure the player sprite is on top
	type_class = GlobalVars.player_node_ref.type_class
	health = GlobalVars.player_node_ref.consumable_amt
	ani_dict = type_class.special_animations_dict
	battle_dict = type_class.special_moves_dict
	max_dodge_charges = type_class.starting_dodge_charges
	max_attack_charges = type_class.starting_attack_charges
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/player_frames.tres"))
	add_child(ani_sprite)
	ani_sprite.set_frame(type_class.sprite_frame)
	setup_animations()
	setup_timers()
	ready_up_player()

func ready_up_player():
	print("player ready")
	current_player_state = game_state.ready

func setup_timers():
	dodge_charge_timer = Timer.new()
	dodge_charge_timer.name = "Dodge Timer"
	add_child(dodge_charge_timer)
	dodge_charge_timer.add_to_group("timers")
	dodge_charge_timer.set_wait_time(type_class.starting_dodge_recharge_speed)
	dodge_charge_timer.set_one_shot(false)
	dodge_charge_timer.connect("timeout", self, "recharge_dodge")
	dodge_charge_timer.start()
	
	attack_charge_timer = Timer.new()
	attack_charge_timer.name = "Attack Timer"
	add_child(attack_charge_timer)
	attack_charge_timer.add_to_group("timers")
	attack_charge_timer.set_wait_time(GlobalVars.player_node_ref.type_class.starting_attack_recharge_speed)
	attack_charge_timer.set_one_shot(false)
	attack_charge_timer.connect("timeout", self, "recharge_attack")
	attack_charge_timer.start()
	pass

func recharge_attack():
	get_tree().call_group("UI_Player_Info", "update_battle_charges")
	if current_attack_charges < max_attack_charges:
		if current_attack_charges + type_class.starting_attack_recharge_amount > max_attack_charges:
			current_attack_charges = max_attack_charges
		else:
			current_attack_charges += type_class.starting_attack_recharge_amount

func recharge_dodge():
	get_tree().call_group("UI_Player_Info", "update_battle_charges")
	if current_dodge_charges < max_dodge_charges:
		if current_dodge_charges + type_class.starting_dodge_recharge_amount > max_dodge_charges:
			current_dodge_charges = max_dodge_charges
		else:
			current_dodge_charges += type_class.starting_dodge_recharge_amount

func _input(event):
	if current_player_state != game_state.ready:
		return
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_A:
				current_player_state = game_state.attack
				attack()
				#tell player to attack
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			if event.scancode == KEY_UP:
				current_player_state = game_state.dodge
				dodge("up")
				#tell player to dodge up
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			if event.scancode == KEY_DOWN:
				current_player_state = game_state.dodge
				dodge("down")
				#tell player to dodge down
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			

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
		current_player_state = game_state.dead
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
		is_dead = true
	print("Player health: "+ str(health))

func attack():
	print("player attack")
	current_player_state = game_state.ready
	if current_attack_charges > 0:
		current_attack_charges -= 1
#	attack_class.attack()

func dodge(direction):
	print("player dodge " + direction)
	current_player_state = game_state.ready
	if current_dodge_charges > 0:
		current_dodge_charges -= 1
#	dodge_class.dodge(direction)
