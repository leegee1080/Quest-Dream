extends Node2D

var diff = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = Player.new(Player.player_types_enum.soldier, 0, diff, {})
var test_enemy = Enemy.new(Enemy.enemy_types_enum.rat, diff)



var number_of_tiles = 36
var rows = 6
var col = 6


func _ready():
	add_child(player)
	player.name = player.type_class.name
	player.position.x = 10
	player.position.y = 100
	add_child(test_enemy)
	test_enemy.name = test_enemy.type_class.name
	test_enemy.position.x = 10
	test_enemy.position.y = 200
	place_tiles()
	pass


const multi = [
	Tile_Enums.tile_directions_enum.cross,
	Tile_Enums.tile_directions_enum.elbow,
	Tile_Enums.tile_directions_enum.tee,
	Tile_Enums.tile_directions_enum.straight
]
const multi2 = [
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.none,
	Tile_Enums.center_type_enum.rest,
	Tile_Enums.center_type_enum.battle,
	Tile_Enums.center_type_enum.treasure,
	Tile_Enums.center_type_enum.shop,
	Tile_Enums.center_type_enum.silly
]

func place_tiles():
	while col > 0:
		rows = 6
		while rows > 0:
			randomize()
			multi.shuffle()
			var chosen_tile_type = multi[0]
			multi2.shuffle()
			var chosen_tile_center = multi2[0]
			#direction, theme, center, level, diff, deco amount, center level
			var test_tile = Tile.new(chosen_tile_type, Tile_Enums.tile_themes_enum.castle, chosen_tile_center, 0, diff, 1, 0)
			$PlayAreaCoordSystem.add_child(test_tile)
			var xpos = col * 48
			var ypos = rows * 48
			test_tile.name = str(xpos)+","+str(ypos)
			test_tile.position.x = xpos
			test_tile.position.y = ypos
			rows -= 1
		col -= 1
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
