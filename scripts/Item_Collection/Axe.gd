class_name Axe

var name = "Axe"
var sprite_frames = [10,11,12,14,15,17,19] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 15,
	"speed": 1,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
