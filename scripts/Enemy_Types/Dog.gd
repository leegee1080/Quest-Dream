class_name Dog

export(String) var name = "Dog"
export(int) var sprite_frame = 12
var stat_dict = {
	"health": 2,
	"attack": 2,
	"speed": 4,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
