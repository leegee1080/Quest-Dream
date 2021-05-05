class_name Human_Wizard

export(String) var name = "Wizard"
export(int) var sprite_frame = 5
var stat_dict = {
	"health": 60,
	"attack": 30,
	"speed": 40,
	"loot" : 40,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
