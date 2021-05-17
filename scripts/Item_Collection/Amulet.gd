class_name Amulet

var name = "Amulet"
var sprite_frames = [64,64,64,64,64,64,64] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 5,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
