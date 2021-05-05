class_name Avatar

export(String) var name = "Avatar of Death"
export(int) var sprite_frame = 0
var stat_dict = {
	"health": 1000,
	"attack": 1000,
	"speed": 1000,
	"loot" : 1000,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
