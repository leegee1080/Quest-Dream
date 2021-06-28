extends Node

class_name Weak_Defend

var animation_class = null

func defend(damage):
	get_parent().health -= damage
	pass
