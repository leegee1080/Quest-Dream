extends Node

class_name UI_Vars

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

static func generate_button(button_loc_dict, sprite_frames_file_loc, button_size, button_container_name, new_z_index, button_parent_node):
	var temp_button_list = []
	for btn in button_loc_dict:
		var temp_btn = Btn.new(button_loc_dict[btn][0], sprite_frames_file_loc, button_loc_dict[btn][1], button_loc_dict[btn][2], button_size)
		temp_btn.local_name = btn
		temp_btn.connect("ui_sig", button_parent_node, "ui_func")
		temp_button_list.append(temp_btn)
		temp_btn.z_index = new_z_index
		button_parent_node.add_child(temp_btn)
	UiVars.buttons_dict[button_container_name] = temp_button_list
	pass
