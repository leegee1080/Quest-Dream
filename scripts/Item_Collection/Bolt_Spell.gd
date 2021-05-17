class_name Bolt_Spell

var name = "Bolt_Spell"
var sprite_frames = [70,70,70,70,74,74,74] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 5,
	"speed": 3,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
