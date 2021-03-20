class_name Human_Queen

export(String) var name = "The Queen"
export(int) var sprite_frame = 8
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
