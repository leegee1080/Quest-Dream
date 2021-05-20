extends Node

var clicked
var buttons_dict = {}

func _input(event):
	if event is InputEventMouseButton:
		if clicked:
			clicked = false
			return
		else:
			clicked = true
			return

