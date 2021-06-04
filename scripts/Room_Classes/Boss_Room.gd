extends Node2D

class_name Boss_Room

func _init():
	pass

func complete_battle():
	get_parent().complete_room()
	pass
