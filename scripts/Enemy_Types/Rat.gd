class_name Rat

export(String) var name = "Rat"
export(int) var sprite_frame = 10
var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 1,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
