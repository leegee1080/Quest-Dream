class_name Human_King

export(String) var name = "The King"
export(int) var sprite_frame = 9
var stat_dict = {
	"health": 60,
	"attack": 60,
	"speed": 60,
	"loot" : 60,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
