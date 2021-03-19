class_name Soldier

export(String) var name = "Soldier"
export(int) var sprite_frame = 0
var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"magic" : 10,
	"equipment": {},
}

func special():
	print("special")
