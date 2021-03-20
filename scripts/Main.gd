extends Node2D

var diff = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = Player.new(Player.player_types_enum.soldier, 1, diff, {})
var test_enemy = Enemy.new(Enemy.enemy_types_enum.rat, diff)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(player)
	player.position.x = 10
	player.position.y = 10
	add_child(test_enemy)
	test_enemy.position.x = 10
	test_enemy.position.y = 20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
