class_name Animation_Enums

const ani_dict = {#dictionary of all the animation classes
	"wiggle_in_place" : Walking_Animation,
	"hit_color_change" : Hit_Color_Animation,
	"blink_sprite" : null,
	"death_flip_red" : Death_Animation
}

const dodge_dict = {
	"teleport" : null,
	"dodge_roll" : Roll_Dodge_1
}

const attack_dict = {
	"throw_projectile" : null,
	"tackle": Tackle_Attack_1,
	"tackle_and_return" : null,
	"tackle_p": Player_Tackle_Attack
}

const defend_dict = {
	"weak": Weak_Defend
}

const turn_dict = {
	"simple_attack": Simple_Attack_Turn,
	"attack_then_move_random_direction": Attack_Then_Move_Random_Turn
}
