class_name Chest

var name = "Chest"
var sprite_frames = [30,31,32,34,35,37,39] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 1,
	"armor": 10,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
