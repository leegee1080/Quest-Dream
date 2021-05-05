class_name Human_Jack

export(String) var name = "Court Jack"
export(int) var sprite_frame = 7
var stat_dict = {
	"health": 40,
	"attack": 40,
	"speed": 40,
	"loot" : 40,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
