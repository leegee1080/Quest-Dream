class_name Bat

export(String) var name = "Bat"
export(int) var sprite_frame = 11
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
