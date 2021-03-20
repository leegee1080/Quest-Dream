class_name Robber

export(String) var name = "Highway Man"
export(int) var sprite_frame = 4
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
