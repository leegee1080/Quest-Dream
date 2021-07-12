extends Node

class_name Player_Tackle_Attack

var sprite_frame = 2
var melee_attack_animation_timer
var melee_return_animation_timer

const attack_step_time = 0.01
const return_step_time = 0.01
const speed = 5

var damage_on_strike = 1
var animation_target
var target_lane

var ani_sprite

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite
	pass

func _ready():
	add_to_group("AnimationClasses")
	
	ani_sprite = get_parent().ani_sprite

	melee_attack_animation_timer = Timer.new()
	add_child(melee_attack_animation_timer)
	melee_attack_animation_timer.add_to_group("timers")
	melee_attack_animation_timer.set_wait_time(attack_step_time)
	melee_attack_animation_timer.set_one_shot(false)
	melee_attack_animation_timer.connect("timeout", self, "attack_step")

	melee_return_animation_timer = Timer.new()
	add_child(melee_return_animation_timer)
	melee_return_animation_timer.add_to_group("timers")
	melee_return_animation_timer.set_wait_time(return_step_time)
	melee_return_animation_timer.set_one_shot(false)
	melee_return_animation_timer.connect("timeout", self, "return_step")

func attack(lane, damage):
	print("tackle attack")
	animation_target = Vector2(get_parent().position.x + 80, get_parent().position.y)
	damage_on_strike = damage
	target_lane = lane
	get_parent().current_attack_charges -= 1
	for enemy in GlobalVars.battle_participants_node_array:
		if enemy.lane_index == target_lane:
			enemy.take_hit(damage_on_strike)
	melee_attack_animation_timer.start()
	pass

func attack_step():
	var yeet = (ani_sprite.global_position - animation_target)/ (-speed)
	ani_sprite.global_position += yeet
	if ani_sprite.global_position.distance_to(animation_target) < 2:
		melee_attack_animation_timer.stop()
		melee_return_animation_timer.start()
		pass
	pass

func return_step():
	var yeet = (ani_sprite.position - Vector2.ZERO)* (-speed)
	ani_sprite.position += yeet.normalized() * 6
	if ani_sprite.position.distance_to(Vector2.ZERO) < 1:
		stop_animation()
	pass

func stop_animation():
	ani_sprite.position = Vector2.ZERO
	get_parent().current_battle_state = Battle_Enums.battle_states.ready
	melee_return_animation_timer.stop()

func terminate_animation():
	melee_attack_animation_timer.stop()
	melee_return_animation_timer.stop()
