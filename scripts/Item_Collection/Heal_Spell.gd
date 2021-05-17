class_name Heal_Spell

var name = "Heal_Spell"
var sprite_frames = [72,72,72,72,76,76,76] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 1,
	"armor": 0,
	"healing" : 10,
}

func use(boost):
	print(name + " has been used.")
