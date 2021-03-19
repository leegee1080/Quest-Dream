class_name Ranger

export(String) var name = "Ranger"
export(int) var sprite_frame = 2
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("special")
