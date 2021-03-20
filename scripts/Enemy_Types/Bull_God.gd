class_name Bull_God

export(String) var name = "Bull God"
export(int) var sprite_frame = 26
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
