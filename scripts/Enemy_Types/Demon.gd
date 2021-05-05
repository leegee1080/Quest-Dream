class_name Demon

export(String) var name = "Demon"
export(int) var sprite_frame = 23
var stat_dict = {
	"health": 18,
	"attack": 14,
	"speed": 15,
	"loot" : 10,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
