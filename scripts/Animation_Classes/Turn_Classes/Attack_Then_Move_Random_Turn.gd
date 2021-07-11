extends Node

class_name Attack_Then_Move_Random_Turn

var parent_sprite

func _init(ani_sprite):
	parent_sprite = ani_sprite
	pass

func process_turn():
	get_parent().attack()
	pass
