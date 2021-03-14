class_name Enemy_Type

var chosen_type

func _init(new_forced_type):
	if new_forced_type == null:
		#random type
		return
	chosen_type = new_forced_type

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

const avatar = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile200.png"
}
const goblin = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile201.png"
}
const goblin_wizard = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile202.png"
}
const monkey = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile203.png"
}
const robber = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile204.png"
}
const human_wizard = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile205.png"
}
const human_sorcerer = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile206.png"
}
const human_jack = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile207.png"
}
const human_queen = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile208.png"
}
const human_king = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile209.png"
}
const rat = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile210.png"
}
const bat = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile211.png"
}
const dog = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile212.png"
}
const snake = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile213.png"
}
const spider_tiny = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile214.png"
}
const spider_big = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile215.png"
}
const eye = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile216.png"
}
const slime_tiny = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile217.png"
}
const slime_big = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile218.png"
}
const vines = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile219.png"
}
const slime_boss = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile220.png"
}
const goblin_boss = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile221.png"
}
const undead = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile222.png"
}
const demon = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile223.png"
}
const vampire = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile224.png"
}
const lich = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile225.png"
}
const bull_god = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile226.png"
}
const golem_god = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon":"res://assets/visuals/tile227.png"
}
const alien_god = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile228.png"
}
const dragon_god = {
	"base_health": 10,
	"base_attack": 10,
	"base_speed": 10,
	"base_loot": 10,
	"icon": "res://assets/visuals/tile229.png"
}

const enemy_types_dict = {
	enemy_types_enum.avatar: avatar,
	enemy_types_enum.goblin: goblin,
	enemy_types_enum.goblin_wizard: goblin_wizard,
	enemy_types_enum.monkey: monkey,
	enemy_types_enum.robber: robber,
	enemy_types_enum.human_wizard: human_wizard,
	enemy_types_enum.human_sorcerer: human_sorcerer,
	enemy_types_enum.human_jack: human_jack,
	enemy_types_enum.human_queen: human_queen,
	enemy_types_enum.human_king: human_king,
	enemy_types_enum.rat: rat,
	enemy_types_enum.bat: bat,
	enemy_types_enum.dog: dog,
	enemy_types_enum.snake: snake,
	enemy_types_enum.spider_tiny: spider_tiny,
	enemy_types_enum.spider_big: spider_big,
	enemy_types_enum.eye: eye,
	enemy_types_enum.slime_tiny: slime_tiny,
	enemy_types_enum.slime_big: slime_big,
	enemy_types_enum.vines: vines,
	enemy_types_enum.slime_boss: slime_boss,
	enemy_types_enum.goblin_boss: goblin_boss,
	enemy_types_enum.undead: undead,
	enemy_types_enum.demon: demon,
	enemy_types_enum.vampire: vampire,
	enemy_types_enum.lich: lich,
	enemy_types_enum.bull_god: bull_god,
	enemy_types_enum.golem_god: golem_god,
	enemy_types_enum.alien_god: alien_god,
	enemy_types_enum.dragon_god: dragon_god
}

