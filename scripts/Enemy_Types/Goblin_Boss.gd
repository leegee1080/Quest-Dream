class_name Goblin_Boss

export(String) var name = "Goblin Boss"
export(int) var sprite_frame = 21
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