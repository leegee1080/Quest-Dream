class_name Slime_Boss

export(String) var name = "Slime Boss"
export(int) var sprite_frame = 20
var stat_dict = {
	"health": 1000,
	"attack": 50,
	"speed": 20,
	"loot" : 50,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
