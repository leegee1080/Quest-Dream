class_name Room_Type

enum tile_themes_enum{
	castle,
	forest,
	swamp,
	mountain,
	graveyard
}
const castle = {
	"name": "Castle",
	"deco_texture_list": ["res://assets/visuals/tile190.png"],
	"battle_texture_list" : {
		"boss" : "res://assets/visuals/tile002.png",
		"elite" : "res://assets/visuals/tile004.png",
		"normal" : "res://assets/visuals/tile006.png",
		"trash" : "res://assets/visuals/tile008.png"
		}
}
const forest = {
	"name": "Forest",
	"deco_texture_list": ["res://assets/visuals/tile190.png"],
	"battle_texture_list" : {
		"boss" : "res://assets/visuals/tile002.png",
		"elite" : "res://assets/visuals/tile004.png",
		"normal" : "res://assets/visuals/tile006.png",
		"trash" : "res://assets/visuals/tile008.png"
		}
}
const swamp = {
	"name": "Swamp",
	"deco_texture_list": ["res://assets/visuals/tile190.png"],
	"battle_texture_list" : {
		"boss" : "res://assets/visuals/tile002.png",
		"elite" : "res://assets/visuals/tile004.png",
		"normal" : "res://assets/visuals/tile006.png",
		"trash" : "res://assets/visuals/tile008.png"
		}
}
const mountain = {
	"name": "Caves",
	"deco_texture_list": ["res://assets/visuals/tile190.png"],
	"battle_texture_list" : {
		"boss" : "res://assets/visuals/tile002.png",
		"elite" : "res://assets/visuals/tile004.png",
		"normal" : "res://assets/visuals/tile006.png",
		"trash" : "res://assets/visuals/tile008.png"
		}
}
const graveyard = {
	"name": "Desicrated",
	"deco_texture_list": ["res://assets/visuals/tile190.png"],
	"battle_texture_list" : {
		"boss" : "res://assets/visuals/tile002.png",
		"elite" : "res://assets/visuals/tile004.png",
		"normal" : "res://assets/visuals/tile006.png",
		"trash" : "res://assets/visuals/tile008.png"
		}
}
const room_themes_dict = {
	tile_themes_enum.castle: castle,
	tile_themes_enum.forest: forest,
	tile_themes_enum.swamp: swamp,
	tile_themes_enum.mountain: mountain,
	tile_themes_enum.graveyard: graveyard
}

enum room_types_enum{
	shop,
	freeEquip,
	freeConsume,
	freeSpell,
	fight,
	rest,
	silly,
	none
}
class silly = {
	"name": "Fun",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile063.png"
}
const shop = {
	"name": "Shop",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile077.png"
}
const freeEquip = {
	"name": "Treasure",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile084.png"
}
const freeConsume = {
	"name": "Treasure",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile086.png"
}
const freeSpell = {
	"name": "Library",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile088.png"
}
const fight = {
	"name": "Battle",
	"theme+Bool" : true,
	"icon": ""
}
const rest = {
	"name": "Rest",
	"theme+Bool" : false,
	"icon": "res://assets/visuals/tile087.png"
}
const none = {
	"name": "",
	"theme+Bool" : true,
	"icon": ""
}
const room_types_dict = {
	room_types_enum.silly: castle,
	room_types_enum.shop: shop,
	room_types_enum.freeEquip: freeEquip,
	room_types_enum.freeConsume: freeConsume,
	room_types_enum.freeSpell: freeSpell,
	room_types_enum.fight: fight,
	room_types_enum.rest: rest,
	room_types_enum.none: none
}
