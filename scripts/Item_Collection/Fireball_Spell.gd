class_name Fireball_Spell

var name = "Fireball_Spell"
var sprite_frames = [71,71,71,71,75,75,75] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 1,
	"speed": 3,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
