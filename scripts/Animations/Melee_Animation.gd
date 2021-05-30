extends Node2D

class_name Melee_Animation

var ani_sprite
var melee_attack_animation_timer
var melee_return_animation_timer

const attack_step = 0.01
const return_step = 0.01
const speed = 10

var damage_on_strike
var target

func _init(new_ani_sprite):
	ani_sprite = new_ani_sprite

func _ready():
	melee_attack_animation_timer = Timer.new()
	add_child(melee_attack_animation_timer)
	melee_attack_animation_timer.add_to_group("timers")
	melee_attack_animation_timer.set_wait_time(attack_step)
	melee_attack_animation_timer.set_one_shot(false)
	melee_attack_animation_timer.connect("timeout", self, "attack_step")
	
	melee_return_animation_timer = Timer.new()
	add_child(melee_return_animation_timer)
	melee_return_animation_timer.add_to_group("timers")
	melee_return_animation_timer.set_wait_time(return_step)
	melee_return_animation_timer.set_one_shot(false)
	melee_return_animation_timer.connect("timeout", self, "return_step")

func play_animation(new_target, new_damage):
	target = new_target
	damage_on_strike = new_damage
	melee_attack_animation_timer.start()

func attack_step():
	var yeet = (ani_sprite.global_position - target.position)/ (-speed)
	ani_sprite.global_position += yeet
	if ani_sprite.global_position.distance_to(target.position) < 2:
		target.take_hit(damage_on_strike)
		melee_attack_animation_timer.stop()
		melee_return_animation_timer.start()
		pass
	pass

func return_step():
	var yeet = (ani_sprite.position - Vector2.ZERO)* (-speed)
	ani_sprite.position += yeet.normalized()
	if ani_sprite.position.distance_to(Vector2.ZERO) < 1:
		stop_animation()
	pass

func stop_animation():
	ani_sprite.position = Vector2.ZERO
	melee_return_animation_timer.stop()
