class_name Spider_Tiny

export(String) var name = "Spider"
export(int) var sprite_frame = 14
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
