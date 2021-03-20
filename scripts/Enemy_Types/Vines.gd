class_name Vines

export(String) var name = "Virulent Vines"
export(int) var sprite_frame = 19
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
