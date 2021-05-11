class_name Berserker

export(String) var name = "Berserker"
export(int) var sprite_frame = 3
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
