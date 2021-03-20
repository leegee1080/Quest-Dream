class_name Human_Jack

export(String) var name = "Court Jack"
export(int) var sprite_frame = 7
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
