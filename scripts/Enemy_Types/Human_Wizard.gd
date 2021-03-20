class_name Human_Wizard

export(String) var name = "Wizard"
export(int) var sprite_frame = 5
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"loot" : 10,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
