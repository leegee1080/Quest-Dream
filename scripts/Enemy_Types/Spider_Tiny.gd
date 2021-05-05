class_name Spider_Tiny

export(String) var name = "Spider"
export(int) var sprite_frame = 14
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
