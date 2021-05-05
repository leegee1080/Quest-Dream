class_name Lich

export(String) var name = "Lich"
export(int) var sprite_frame = 25
var stat_dict = {
	"health": 60,
	"attack": 60,
	"speed": 60,
	"loot" : 60,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
