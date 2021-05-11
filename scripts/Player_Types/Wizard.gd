class_name Wizard

export(String) var name = "Wizard"
export(int) var sprite_frame = 7
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("player attacked")

func take_hit():
	print("player took hit")