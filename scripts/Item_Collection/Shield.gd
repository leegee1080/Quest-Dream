class_name Shield

var name = "Shield"
var sprite_frames = [40,42,43,44,45,47,49] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 5,
	"speed": 1,
	"armor": 5,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
