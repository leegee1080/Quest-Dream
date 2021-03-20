class_name Golem_God

export(String) var name = "Golem God"
export(int) var sprite_frame = 27
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
