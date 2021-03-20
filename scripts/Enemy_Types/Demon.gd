class_name Demon

export(String) var name = "Demon"
export(int) var sprite_frame = 23
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
