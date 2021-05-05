class_name Snake

export(String) var name = "Snake"
export(int) var sprite_frame = 13
var stat_dict = {
	"health": 4,
	"attack": 4,
	"speed": 3,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
