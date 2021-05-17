class_name Money

var name = "Money"
var sprite_frames = [60,60,60,60,61,61,61] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 0,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
