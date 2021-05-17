class_name Stun_Spell

var name = "Stun_Spell"
var sprite_frames = [69,69,69,69,72,72,72] #must be 7 items to match with the rarity

var stat_dict = {
	"damage": 0,
	"speed": 3,
	"armor": 0,
	"healing" : 0,
}

func use(boost):
	print(name + " has been used.")
