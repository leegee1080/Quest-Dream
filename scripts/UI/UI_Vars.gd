extends Node

class_name UI_Vars

#var clicked = false
#var misclick = false
var buttons_dict = {}
var is_trans = false

#func _input(event):
#	if event is InputEventMouseButton:
#		print("click")
#		if clicked:
#			print("unclock")
#			clicked = false
#			click_reset_check()
#			return
#		else:
#			print("clock")
#			clicked = true
#			click_reset_check()
#			return

#func click_reset_check():
#	if clicked == true:
#		misclick = true
#	if clicked == false:
#		misclick = false
#	pass

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

static func hide_buttons(button_container_name):
	if button_container_name in UiVars.buttons_dict:
		var list_to_check = UiVars.buttons_dict[button_container_name]
		for button in list_to_check:
			if button == null:
				continue
			button.queue_free()
	pass

static func disable_button(button_container_name):
	if button_container_name in UiVars.buttons_dict:
		var list_to_check = UiVars.buttons_dict[button_container_name]
		for button in list_to_check:
			if button == null or button.name == "ignore":
				continue
			button.clickable = false
	pass

static func enable_button(button_container_name):
	if button_container_name in UiVars.buttons_dict:
		var list_to_check = UiVars.buttons_dict[button_container_name]
		for button in list_to_check:
			if button == null or button.name == "ignore":
				continue
			button.clickable = true
	pass
