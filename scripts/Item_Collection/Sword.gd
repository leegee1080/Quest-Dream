class_name Sword

var name = "Sword"
var sprite_frames = [0,1,2,4,5,7,9] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 10,
	"speed": 2,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
