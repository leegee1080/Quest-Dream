extends Node2D

class_name Treasure_Room

var leave_timer

func _ready():
	leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	get_parent().timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(get_parent().leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_room")
	leave_timer.add_to_group("timers")
	leave_timer.start()
	pass

func _init():
	pass

func complete_open_chest():
	get_parent().complete_room()
	pass
