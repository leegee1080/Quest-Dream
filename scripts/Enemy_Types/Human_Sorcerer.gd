class_name Human_Sorcerer

export(String) var name = "Sorcerer"
export(int) var sprite_frame = 6
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
