extends Node2D

class_name Rest_Room

var leave_timer

func _init():
	pass

func _ready():
	var leave_timer = Timer.new()
	leave_timer.name = "Leave Timer"
	get_parent().timer_group.add_child(leave_timer)
	leave_timer.set_wait_time(get_parent().leave_time)
	leave_timer.set_one_shot(true)
	leave_timer.connect("timeout", self, "complete_rest")
	leave_timer.start()
	GlobalVars.player_node_ref.health = GlobalVars.player_node_ref.type_class.starting_health

func complete_rest():
	get_parent().complete_room()
	pass
