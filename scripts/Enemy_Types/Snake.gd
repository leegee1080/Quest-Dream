class_name Snake

export(String) var name = "Snake"
export(int) var sprite_frame = 13
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
