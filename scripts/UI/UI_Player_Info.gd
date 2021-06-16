extends Node2D

class_name UI_Player_Info

const ui_pos = Vector2(110,315)
const item_spritesheet = "res://assets/visuals/item_frames.tres"

#vars for the consumable UI element
var consumable_sprite_frame
const consumable_sprite_pos = Vector2(0,0)
var consumable_sprite_node

#vars for the money UI element
const money_sprite_frame = 60
const money_sprite_pos = Vector2(0,50)
var money_sprite_node

#vars for text elements
var rtl_node_consumable
var rtl_node_money
const rect_size = Vector2(50,50)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const text_scale = 0.1


func _ready():
	var loaded_font = load(font)
	add_to_group("UI_Player_Info")
	position = ui_pos
	
	consumable_sprite_node = AnimatedSprite.new()
	consumable_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(consumable_sprite_node)
	consumable_sprite_node.set_frame(consumable_sprite_frame)
	consumable_sprite_node.position = consumable_sprite_pos
	rtl_node_consumable = Label.new()
	add_child(rtl_node_consumable)
	rtl_node_consumable.rect_position = Vector2(consumable_sprite_pos.x + 20, consumable_sprite_pos.y - 5)
	rtl_node_consumable.rect_scale = Vector2(text_scale,text_scale)
	rtl_node_consumable.rect_size = rect_size
	rtl_node_consumable.text = str(GlobalVars.player_node_ref.consumable_amt)
	rtl_node_consumable.add_font_override("font", load(font))
#	rtl_node_consumable.margin_left = 0
#	rtl_node_consumable.margin_top = 0
	
	money_sprite_node = AnimatedSprite.new()
	money_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(money_sprite_node)
	money_sprite_node.set_frame(money_sprite_frame)
	money_sprite_node.position = money_sprite_pos
	rtl_node_money = Label.new()
	add_child(rtl_node_money)
	rtl_node_money.rect_position = Vector2(money_sprite_pos.x + 20, money_sprite_pos.y - 5)
	rtl_node_money.rect_scale = Vector2(text_scale,text_scale)
	rtl_node_money.rect_size = rect_size
	rtl_node_money.text = str(GlobalVars.money_gained_this_run)
	rtl_node_money.add_font_override("font", load(font))
#	rtl_node_money.margin_left = 0
#	rtl_node_money.margin_top = 0
	pass

func _init(player_consumable_frame):
	consumable_sprite_frame = player_consumable_frame

func update_consumable():
	rtl_node_consumable.text = str(GlobalVars.player_node_ref.consumable_amt)

func update_money():
	rtl_node_money.text = str(GlobalVars.money_gained_this_run)
