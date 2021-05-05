class_name Alien_God

export(String) var name = "Alien God"
export(int) var sprite_frame = 28
var stat_dict = {
	"health": 100,
	"attack": 100,
	"speed": 100,
	"loot" : 100,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
