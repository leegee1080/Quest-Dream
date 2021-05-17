class_name Bow

var name = "Bow"
var sprite_frames = [20,24,25,26,27,28,29] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 5,
	"speed": 3,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
