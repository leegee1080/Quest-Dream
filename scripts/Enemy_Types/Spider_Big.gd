class_name Spider_Big

export(String) var name = "Giant Spider"
export(int) var sprite_frame = 15
var stat_dict = {
	"health": 10,
	"attack": 4,
	"speed": 10,
	"loot" : 4,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
