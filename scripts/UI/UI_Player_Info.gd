extends Node

class_name UI_Player_Info

const ui_pos = Vector2(0,0)
const item_spritesheet = "res://assets/visuals/item_frames.tres"

#vars for the consumable UI element
var consumable_sprite_frame
const consumable_sprite_pos = Vector2(110,350)
var consumable_sprite_node

#vars for the money UI element
const money_sprite_frame = 60
const money_sprite_pos = Vector2(110,400)
var money_sprite_node

#vars for text elements
var rtl_node_consumable
var rtl_node_money

func _ready():
	consumable_sprite_node = AnimatedSprite.new()
	consumable_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(consumable_sprite_node)
	consumable_sprite_node.set_frame(consumable_sprite_frame)
	consumable_sprite_node.position = consumable_sprite_pos
	rtl_node_consumable = RichTextLabel.new()
	add_child(rtl_node_consumable)
#	rtl_node_consumable.rect.position = Vector2(consumable_sprite_pos.x + 20, consumable_sprite_pos.y)
	
	money_sprite_node = AnimatedSprite.new()
	money_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(money_sprite_node)
	money_sprite_node.set_frame(money_sprite_frame)
	money_sprite_node.position = money_sprite_pos
	rtl_node_money = RichTextLabel.new()
	add_child(rtl_node_money)
#	rtl_node_money.rect.position = Vector2(money_sprite_pos.x + 20, money_sprite_pos.y)
	pass

func _init(player_consumable_frame):
	consumable_sprite_frame = player_consumable_frame

#func _process(_delta):
#	rtl_node_consumable.text = GlobalVars.player_node_ref.consumable
#	rtl_node_money.text = GlobalVars.money_gained_this_run
