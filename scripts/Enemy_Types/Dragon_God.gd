class_name Dragon_God

export(String) var name = "Dragon God"
export(int) var sprite_frame = 29
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
