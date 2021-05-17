class_name Ring

var name = "Ring"
var sprite_frames = [62,62,62,62,63,63,63] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 5,
	"speed": 0,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
