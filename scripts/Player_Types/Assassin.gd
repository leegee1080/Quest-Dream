class_name Assassin

export(String) var name = "Assassin"
export(int) var sprite_frame = 6
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("attacked")

func take_hit():
	print("took hit")
