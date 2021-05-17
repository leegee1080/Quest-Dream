class_name Helmet

var name = "Helmet"
var sprite_frames = [51,52,53,54,56,57,59] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 1,
	"armor": 5,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
