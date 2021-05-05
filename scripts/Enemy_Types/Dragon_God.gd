class_name Dragon_God

export(String) var name = "Dragon God"
export(int) var sprite_frame = 29
var stat_dict = {
	"health": 200,
	"attack": 100,
	"speed": 110,
	"loot" : 100,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
