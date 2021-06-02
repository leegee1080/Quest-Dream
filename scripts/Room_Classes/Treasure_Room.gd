extends Node2D

class_name Treasure_Room

const can_return_to_room = true


func _init():
	pass

func complete_open_chest():
	get_parent().complete_room()
	pass
