extends Node2D

class_name Rest_Room

const can_return_to_room = true


func _init():
	pass

func complete_rest():
	get_parent().complete_room()
	pass
