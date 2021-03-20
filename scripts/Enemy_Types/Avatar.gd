class_name Avatar

export(String) var name = "Avatar of Death"
export(int) var sprite_frame = 0
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
