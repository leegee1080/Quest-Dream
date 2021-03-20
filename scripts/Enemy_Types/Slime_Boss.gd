class_name Slime_Boss

export(String) var name = "Slime Boss"
export(int) var sprite_frame = 20
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
