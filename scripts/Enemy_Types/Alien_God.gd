class_name Alien_God

export(String) var name = "Alien God"
export(int) var sprite_frame = 28
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
