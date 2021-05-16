class_name Sword

var name = "Sword"
var sprite_frames = [19,0]

var stat_dict = {
	"damage": 10,
	"speed": 1,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
