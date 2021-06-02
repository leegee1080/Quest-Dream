extends Node2D

class_name Boss_Room

const can_return_to_room = false

func _init():
	pass

func complete_battle():
	get_parent().complete_room()
	pass
