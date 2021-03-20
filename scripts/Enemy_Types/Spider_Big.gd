class_name Spider_Big

export(String) var name = "Giant Spider"
export(int) var sprite_frame = 15
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
