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
var attack_power

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
	type_class = GlobalVars.player_type_class_storage
	attack_power = type_class.starting_attack_power
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
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_A:
				player_command("attack")
				return
			if event.scancode == KEY_UP:
				player_command("dodge_up")
				return
			if event.scancode == KEY_DOWN:
				player_command("dodge_down")
				return
			

func player_command(command):
	if current_battle_state != Battle_Enums.battle_states.ready or is_dead:
		return
	if command == "attack":
		attack()
		return
	if command == "dodge_up":
		dodge("up")
		return
	if command == "dodge_down":
		dodge("down")
		return
	pass

func setup_animations():
	for ani in GlobalVars.player_type_class_storage.special_animations_dict:
		var temp_ani_class
		if GlobalVars.player_type_class_storage.special_animations_dict[ani] == null:
			continue
		temp_ani_class = Animation_Enums.ani_dict[GlobalVars.player_type_class_storage.special_animations_dict[ani]].new(ani_sprite)
		temp_ani_class.name = ani
		add_child(temp_ani_class)
		ani_dict[ani] = temp_ani_class
	battle_dict.attack = Animation_Enums.attack_dict[GlobalVars.player_type_class_storage.special_moves_dict["attack"]].new(ani_sprite)
	battle_dict.dodge = Animation_Enums.dodge_dict[GlobalVars.player_type_class_storage.special_moves_dict["dodge"]].new(ani_sprite)
	add_child(battle_dict.attack)
	add_child(battle_dict.dodge)


func heal_player(new_health):
	GlobalVars.player_consumable_amount += new_health
	print("Player now has "+ str(GlobalVars.player_consumable_amount) + " health left.")

func take_hit(damage):
	if is_dead:
		return
	get_tree().call_group("UI_Player_Info", "update_consumable")
	ani_dict.injure.play_animation()
	GlobalVars.player_consumable_amount -= damage
	if GlobalVars.player_consumable_amount <= 0:
		print("player dead")
		current_battle_state = Battle_Enums.battle_states.dead
		GlobalVars.main_node_ref.lose_round()
		ani_dict.death.play_animation()
		is_dead = true
	print("Player health: "+ str(GlobalVars.player_consumable_amount))

func attack():
	current_battle_state = Battle_Enums.battle_states.attack
	if current_attack_charges > 0:
		attack_charge_timer.start()
		battle_dict.attack.attack(lane_index, attack_power)
	else:
		current_battle_state = Battle_Enums.battle_states.ready
	get_tree().call_group("UI_Player_Info", "update_battle_charges")

func dodge(direction):
	current_battle_state = Battle_Enums.battle_states.dodge
	if current_dodge_charges > 0:
		battle_dict.dodge.dodge(direction)
	else:
		current_battle_state = Battle_Enums.battle_states.ready
	get_tree().call_group("UI_Player_Info", "update_battle_charges")
