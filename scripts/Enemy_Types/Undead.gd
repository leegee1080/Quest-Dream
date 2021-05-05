class_name Undead

export(String) var name = "Undead"
export(int) var sprite_frame = 22
var stat_dict = {
	"health": 20,
	"attack": 10,
	"speed": 5,
	"loot" : 10,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
