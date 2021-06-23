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

var current_battle_state
var previous_battle_state

var lane_index = 2 #this stores a number (0-4) that indicates the lane the player is in for battle

var players_team #a list of the current player's nodes, including: player and all player's summons

func _ready():
	GlobalVars.room_player_node_ref = self
	current_battle_state = Battle_Enums.battle_states.setup
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
	position = Vector2(position.x - type_class.starting_attack_range, position.y)
	setup_animations()
	setup_timers()
	ready_up_player()

func ready_up_player():
	print("player ready")
	current_battle_state = Battle_Enums.battle_states.ready
	players_team = [self]

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
	if current_attack_charges < max_attack_charges:
		if current_attack_charges + type_class.starting_attack_recharge_amount > max_attack_charges:
			current_attack_charges = max_attack_charges
		else:
			current_attack_charges += type_class.starting_attack_recharge_amount
	if current_attack_charges >= max_attack_charges:
		attack_charge_timer.stop()
	get_tree().call_group("UI_Player_Info", "update_battle_charges")

func recharge_dodge():
	if current_dodge_charges < max_dodge_charges:
		if current_dodge_charges + type_class.starting_dodge_recharge_amount > max_dodge_charges:
			current_dodge_charges = max_dodge_charges
		else:
			current_dodge_charges += type_class.starting_dodge_recharge_amount
	if current_dodge_charges >= max_dodge_charges:
		dodge_charge_timer.stop()
	get_tree().call_group("UI_Player_Info", "update_battle_charges")

func _input(event):
	if current_battle_state != Battle_Enums.battle_states.ready:
		return
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_A:
				current_battle_state = Battle_Enums.battle_states.attack
				attack()
				#tell player to attack
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			if event.scancode == KEY_UP:
				current_battle_state = Battle_Enums.battle_states.dodge
				dodge("up")
				#tell player to dodge up
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			if event.scancode == KEY_DOWN:
				current_battle_state = Battle_Enums.battle_states.dodge
				dodge("down")
				#tell player to dodge down
				get_tree().call_group("UI_Player_Info", "update_battle_charges")
				return
			

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

func heal_player(new_health):
	health += new_health
	print("Player now has "+ str(health) + " health left.")

func take_hit(damage):
	get_tree().call_group("UI_Player_Info", "update_consumable")
	ani_dict.injure.play_animation()
	health -= damage
	if health <= 0:
		print("player dead")
		current_battle_state = Battle_Enums.battle_states.dead
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
		is_dead = true
	print("Player health: "+ str(health))

func attack():
	if current_attack_charges > 0:
		attack_charge_timer.start()
		battle_dict.attack.attack()
	else:
		current_battle_state = Battle_Enums.battle_states.ready

func dodge(direction):
	if current_dodge_charges > 0:
		battle_dict.dodge.dodge(direction)
	else:
		current_battle_state = Battle_Enums.battle_states.ready
