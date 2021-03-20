class_name Human_King

export(String) var name = "The King"
export(int) var sprite_frame = 9
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
