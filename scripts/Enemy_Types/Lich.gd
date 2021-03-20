class_name Lich

export(String) var name = "Lich"
export(int) var sprite_frame = 25
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
