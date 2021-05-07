extends Node2D

class_name Enemy

enum enemy_types_enum{
	avatar,
	goblin,
	goblin_wizard,
	monkey,
	robber,
	human_wizard,
	human_sorcerer,
	human_jack,
	human_queen,
	human_king,
	rat,
	bat,
	dog,
	snake,
	spider_tiny,
	spider_big,
	eye,
	slime_tiny,
	slime_big,
	vines,
	slime_boss,
	goblin_boss,
	undead,
	demon,
	vampire,
	lich,
	bull_god,
	golem_god,
	alien_god,
	dragon_god
}
const enemy_types_dict = {
	enemy_types_enum.avatar: Avatar,
	enemy_types_enum.goblin: Goblin,
	enemy_types_enum.goblin_wizard: Goblin_Wizard,
	enemy_types_enum.monkey: Monkey,
	enemy_types_enum.robber: Robber,
	enemy_types_enum.human_wizard: Human_Wizard,
	enemy_types_enum.human_sorcerer: Human_Sorcerer,
	enemy_types_enum.human_jack: Human_Jack,
	enemy_types_enum.human_queen: Human_Queen,
	enemy_types_enum.human_king: Human_King,
	enemy_types_enum.rat: Rat,
	enemy_types_enum.bat: Bat,
	enemy_types_enum.dog: Dog,
	enemy_types_enum.snake: Snake,
	enemy_types_enum.spider_tiny: Spider_Tiny,
	enemy_types_enum.spider_big: Spider_Big,
	enemy_types_enum.eye: Eye,
	enemy_types_enum.slime_tiny: Slime_Tiny,
	enemy_types_enum.slime_big: Slime_Big,
	enemy_types_enum.vines: Vines,
	enemy_types_enum.slime_boss: Slime_Boss,
	enemy_types_enum.goblin_boss: Goblin_Boss,
	enemy_types_enum.undead: Undead,
	enemy_types_enum.demon: Demon,
	enemy_types_enum.vampire: Vampire,
	enemy_types_enum.lich: Lich,
	enemy_types_enum.bull_god: Bull_God,
	enemy_types_enum.golem_god: Golem_God,
	enemy_types_enum.alien_god: Alien_God,
	enemy_types_enum.dragon_god: Dragon_God
}

export(enemy_types_enum) var type_enum


var type_class
export(Dictionary) var stat_dict = {
	"health": 10,
	"attack": 10,
	"speed": 10,
	"loot": 10
}
var is_dead = false

var ani_sprite
var hit_animation

func _ready():
	ani_sprite = AnimatedSprite.new()
	ani_sprite.set_sprite_frames(load("res://assets/visuals/enemy_frames.tres"))
	add_child(ani_sprite)
	hit_animation = Hit_Color_Animation.new(ani_sprite, 0.1, 0.5)
	add_child(hit_animation)
	generate_enemy()

func _init(new_type, power_boost:int):
	if new_type == null:
		randomize()
		var rand_pick = int(rand_range(0, (enemy_types_enum.size()-1)))
		type_enum = enemy_types_dict.keys()[rand_pick]
		pass
	else:
		type_enum = new_type
	stat_dict["health"] = stat_dict["health"] * power_boost
	stat_dict["attack"] = stat_dict["attack"] * power_boost
	stat_dict["speed"] = stat_dict["speed"] * power_boost
	stat_dict["loot"] = stat_dict["loot"] * power_boost

func generate_enemy():
	if type_enum == null:
		type_enum = enemy_types_enum.rat
	type_class = enemy_types_dict.get(type_enum).new()
	print(type_class.name)
	stat_dict = type_class.stat_dict
	ani_sprite.set_frame(type_class.sprite_frame)

func process_turn(target):
	if is_dead == false:
		print("enemy " + str(type_class.name) + " turn")
#		type_class.attack() #needed to play special animations
		target.take_hit(stat_dict.speed)
	return
	
func take_hit(damage):
	type_class.hit()
	hit_animation.start_hit()
	stat_dict.health -= damage
	print(str(type_class.name) + " health left: " + str(stat_dict.health))
	if stat_dict.health <= 0:
		is_dead = true
		print(str(type_class.name) + " is dead")
	return
