class_name Traveler

export(String) var name = "Traveler"
export(int) var sprite_frame = 8
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("special")
