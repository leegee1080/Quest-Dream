class_name Human_Sorcerer

export(String) var name = "Sorcerer"
export(int) var sprite_frame = 6
var stat_dict = {
	"health": 30,
	"attack": 60,
	"speed": 40,
	"loot" : 40,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
