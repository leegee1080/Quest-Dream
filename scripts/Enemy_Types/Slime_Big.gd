class_name Slime_Big

export(String) var name = "Giant Slime"
export(int) var sprite_frame = 18
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
