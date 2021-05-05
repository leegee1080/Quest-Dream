class_name Monkey

export(String) var name = "Monkey"
export(int) var sprite_frame = 3
var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 6,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
