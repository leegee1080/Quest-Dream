extends Node2D

class_name UI_Player_Info

const ui_pos = Vector2(115,320)
const item_spritesheet = "res://assets/visuals/item_frames.tres"

#vars for the consumable UI element
var consumable_sprite_frame
const consumable_sprite_pos = Vector2(0,0)
var consumable_sprite_node

#vars for the money UI element
const money_sprite_frame = 60
const money_sprite_pos = Vector2(0,30)
var money_sprite_node

#vars for attack UI element
var attack_sprite_frame
const attack_sprite_pos = Vector2(0,60)
var attack_sprite_node

#vars for dodge UI element
var dodge_sprite_frame
const dodge_sprite_pos = Vector2(0,90)
var dodge_sprite_node

#vars for text elements
var rtl_node_consumable
var rtl_node_money
var rtl_node_attack
var rtl_node_dodge
const rect_size = Vector2(50,50)
const font = "res://assets/fonts/pixel_dyna_font.tres"
const text_scale = 0.1


func _ready():
	add_to_group("UI_Player_Info")
	position = ui_pos
	
	consumable_sprite_node = AnimatedSprite.new()
	consumable_sprite_node.set_sprite_frames(load(item_spritesheet))
	add_child(consumable_sprite_node)
	consumable_sprite_node.set_frame(consumable_sprite_frame)
	consumable_sprite_node.position = consumable_sprite_pos
	rtl_node_consumable = Label.new()
	add_child(rtl_node_consumable)
	rtl_node_consumable.rect_position = Vector2(consumable_sprite_pos.x, consumable_sprite_pos.y + 5)
	rtl_node_consumable.rect_scale = Vector2(text_scale,text_scale)
	rtl_node_consumable.rect_size = rect_size
	rtl_node_consumable.text = str(GlobalVars.player_consumable_amount)
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
	rtl_node_money.rect_position = Vector2(money_sprite_pos.x, money_sprite_pos.y + 5)
	rtl_node_money.rect_scale = Vector2(text_scale,text_scale)
	rtl_node_money.rect_size = rect_size
	rtl_node_money.text = str(GlobalVars.money_gained_this_run)
	rtl_node_money.add_font_override("font", load(font))
#	rtl_node_money.margin_left = 0
#	rtl_node_money.margin_top = 0
	
#	attack_sprite_node = AnimatedSprite.new()
#	attack_sprite_node.set_sprite_frames(load(item_spritesheet))
#	add_child(attack_sprite_node)
#	attack_sprite_node.set_frame(attack_sprite_frame)
#	attack_sprite_node.position = attack_sprite_pos
#	rtl_node_attack = Label.new()
#	add_child(rtl_node_attack)
#	rtl_node_attack.rect_position = Vector2(attack_sprite_pos.x, attack_sprite_pos.y + 5)
#	rtl_node_attack.rect_scale = Vector2(text_scale,text_scale)
#	rtl_node_attack.rect_size = rect_size
#	rtl_node_attack.text = str(GlobalVars.player_node_ref.type_class.starting_attack_charges)
#	rtl_node_attack.add_font_override("font", load(font))
##	rtl_node_attack.margin_left = 0
##	rtl_node_attack.margin_top = 0
#
#	dodge_sprite_node = AnimatedSprite.new()
#	dodge_sprite_node.set_sprite_frames(load(item_spritesheet))
#	add_child(dodge_sprite_node)
#	dodge_sprite_node.set_frame(dodge_sprite_frame)
#	dodge_sprite_node.position = dodge_sprite_pos
#	rtl_node_dodge = Label.new()
#	add_child(rtl_node_dodge)
#	rtl_node_dodge.rect_position = Vector2(dodge_sprite_pos.x, dodge_sprite_pos.y + 5)
#	rtl_node_dodge.rect_scale = Vector2(text_scale,text_scale)
#	rtl_node_dodge.rect_size = rect_size
#	rtl_node_dodge.text = str(GlobalVars.player_node_ref.type_class.starting_dodge_charges)
#	rtl_node_dodge.add_font_override("font", load(font))
##	rtl_node_dodge.margin_left = 0
##	rtl_node_dodge.margin_top = 0
	pass

func _init(player_consumable_frame):
	consumable_sprite_frame = player_consumable_frame
#	attack_sprite_frame = player_attack_sprite_frame
#	dodge_sprite_frame = player_dodge_sprite_frame

func update_consumable():
	rtl_node_consumable.text = str(GlobalVars.player_consumable_amount)

func update_money():
	rtl_node_money.text = str(GlobalVars.money_gained_this_run)

func update_battle_charges():
	rtl_node_attack.text = str(GlobalVars.room_player_node_ref.current_attack_charges)
	rtl_node_dodge.text = str(GlobalVars.room_player_node_ref.current_dodge_charges)
