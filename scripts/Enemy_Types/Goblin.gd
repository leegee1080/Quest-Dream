class_name Goblin

export(String) var name = "Goblin"
export(int) var sprite_frame = 1
var stat_dict = {
	"health": 2,
	"attack": 2,
	"speed": 2,
	"loot" : 1,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
