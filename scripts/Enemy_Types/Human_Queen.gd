class_name Human_Queen

export(String) var name = "The Queen"
export(int) var sprite_frame = 8
var stat_dict = {
	"health": 50,
	"attack": 50,
	"speed": 50,
	"loot" : 50,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
