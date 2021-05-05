class_name Slime_Big

export(String) var name = "Giant Slime"
export(int) var sprite_frame = 18
var stat_dict = {
	"health": 100,
	"attack": 50,
	"speed": 10,
	"loot" : 50,
}

func attack():
	print("attacked")

func hit():
	print("taken hit")
