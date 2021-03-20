class_name Eye

export(String) var name = "Specter Eye"
export(int) var sprite_frame = 16
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
