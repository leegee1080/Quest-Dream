class_name Assassin

export(String) var name = "Assassin"
export(int) var sprite_frame = 6
var stat_dict = {
	"health": 10,
	"attack": 1,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("player attacked")

func take_hit():
	print("player took hit")
