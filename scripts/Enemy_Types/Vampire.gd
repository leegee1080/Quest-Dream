class_name Vampire

export(String) var name = "Vampire"
export(int) var sprite_frame = 24
var stat_dict = {
	"health": 50,
	"attack": 30,
	"speed": 50,
	"loot" : 30,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
