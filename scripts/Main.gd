extends Node2D

var diff = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = Player.new(Player.player_types_enum.soldier, 1, diff, {})
var test_enemy = Enemy.new(Enemy.enemy_types_enum.rat, diff)
#direction, theme, center, level, diff
var test_tile = Tile.new(Tile_Enums.tile_directions_enum.cross, Tile_Enums.tile_themes_enum.castle, Tile_Enums.center_type_enum.shop, 1, diff)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(player)
	player.position.x = 10
	player.position.y = 10
	add_child(test_enemy)
	test_enemy.position.x = 10
	test_enemy.position.y = 20
	add_child(test_tile)
	test_tile.position.x = 50
	test_tile.position.y = 50
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
