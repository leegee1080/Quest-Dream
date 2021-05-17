class_name Food

var name = "Food"
var sprite_frames = [65,65,65,65,65,65,65] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 1,
	"armor": 0,
	"healing" : 5,
}

func use(boost):
	print(name + " has been used.")
