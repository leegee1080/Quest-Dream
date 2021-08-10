extends Node2D

class_name UI_MainMenu_Player_Info

var ui_pos = Vector2(0,0)
const item_spritesheet = "res://assets/visuals/item_frames.tres"

#vars for the money UI element
const money_sprite_frame = 60
const money_sprite_pos = Vector2(0,0)
var money_sprite_node

#vars for text elements
var rtl_node_money
const rect_size = Vector2(50,50)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const text_scale = 0.1

func _init(new_ui_pos):
	ui_pos = new_ui_pos
	pass

func _ready():
	add_to_group("UI_Player_Info")
	position = ui_pos

	money_sprite_node = AnimatedSprite.new()
	money_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(money_sprite_node)
	money_sprite_node.set_frame(money_sprite_frame)
	money_sprite_node.position = money_sprite_pos
	rtl_node_money = Label.new()
	add_child(rtl_node_money)
	rtl_node_money.rect_position = Vector2(money_sprite_pos.x + 10, money_sprite_pos.y - 10)
	rtl_node_money.rect_scale = Vector2(text_scale,text_scale)
	rtl_node_money.rect_size = rect_size
	rtl_node_money.text = str(GlobalVars.money_gained_total)
	rtl_node_money.add_font_override("font", load(font))
	pass

func update_money():
	#play money sound
	rtl_node_money.text = str(GlobalVars.money_gained_total)
