extends Node

class_name Weak_Defend

var parent_sprite

func _init(ani_sprite):
	parent_sprite = ani_sprite
	pass

func defend(damage):
	get_parent().health -= damage
	pass
