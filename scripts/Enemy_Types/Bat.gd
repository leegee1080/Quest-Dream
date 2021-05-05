class_name Bat

export(String) var name = "Bat"
export(int) var sprite_frame = 11
var stat_dict = {
	"health": 1,
	"attack": 1,
	"speed": 14,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
