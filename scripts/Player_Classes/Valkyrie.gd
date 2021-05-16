class_name Valkyrie

export(String) var name = "Valkyrie"
export(int) var sprite_frame = 1
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
