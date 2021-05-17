class_name Potion

var name = "Potion"
var sprite_frames = [66,66,66,67,67,68,68] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 1,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
