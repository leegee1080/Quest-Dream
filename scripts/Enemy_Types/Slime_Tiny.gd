class_name Slime_Tiny

export(String) var name = "Slime"
export(int) var sprite_frame = 17
var stat_dict = {
	"health": 40,
	"attack": 10,
	"speed": 5,
	"loot" : 10,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
