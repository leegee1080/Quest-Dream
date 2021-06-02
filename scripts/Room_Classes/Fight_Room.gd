extends Node2D

class_name Fight_Room

const can_return_to_room = false

var enemies = [] #current list of enemies so the player doesn't attack already dead enemies
var original_enemies = []#this is the list of enemies that was created at the start of the room
var turn_order = []
const turn_counter_time = 1
var turn_counter

func _init():
	pass

func setup_battle():
	pass

func process_turn(participant_node):
	pass

func complete_battle():
	get_parent().complete_room()
	pass
