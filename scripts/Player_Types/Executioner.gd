class_name Executioner

export(String) var name = "Executioner"
export(int) var sprite_frame = 4
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
