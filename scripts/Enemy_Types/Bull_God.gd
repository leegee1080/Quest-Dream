class_name Bull_God

export(String) var name = "Bull God"
export(int) var sprite_frame = 26
var stat_dict = {
	"health": 100,
	"attack": 100,
	"speed": 90,
	"loot" : 100,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
