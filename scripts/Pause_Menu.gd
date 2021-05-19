extends Node2D


#ui vars
const button_loc_dict = {
	#fill with the locations to instance the button objects
	"back": [Vector2(111,307), 2, 3],
	"quit": [Vector2(191,307), 4, 5],
	"fastforward": [Vector2(191,307), 4, 5]
}


func _init():
	pass


func _ready():
	pass # Replace with function body.


func generate_ui():
	for btn in button_loc_dict:
		var temp_btn = Btn.new(button_loc_dict[btn][0], "res://assets/visuals/button_frames.tres", button_loc_dict[btn][1], button_loc_dict[btn][2], Vector2(66,137))
		temp_btn.name = btn
		add_child(temp_btn)
		temp_btn.connect("ui_sig", self, "iu_func")

func iu_func(new_name): #checks which button is pressed
	if new_name == "back":
		ui_back()
		return
	if new_name == "quit":
		ui_quit()
		return
	if new_name == "fastforward":
		ui_fastforward()
		return

func ui_back():
	pass

func ui_quit():
	pass

func ui_fastforward():
	pass
