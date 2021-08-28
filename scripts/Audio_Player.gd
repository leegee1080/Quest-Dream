extends Node2D

class_name Audio_Player

const default_volume = -25

#GlobalVars.audio_player.play("forestsong") Place this line anywhere I want to play music
#GlobalVars.audio_player.stop("menusong") Place this line anywhere I want to stop music

const audio_dict = {
#	"song_name": ["is_music: T or F", "file_location"]
	"actionplacetile": [false, "res://assets/sounds/actionplacetile.wav"],
	"click": [false, "res://assets/sounds/click.wav"],
	"coinpickup": [false, "res://assets/sounds/coinpickup.wav"],
	"consumepickup": [false, "res://assets/sounds/comsumepickup.wav"],
	"jump": [false, "res://assets/sounds/jump.wav"],
	"notunlock": [false, "res://assets/sounds/notunlockedyet.wav"],
	"unpause": [false, "res://assets/sounds/pause.wav"],
	"fastforward": [false, "res://assets/sounds/winstage.wav"],
	"placetile": [false, "res://assets/sounds/placetile.wav"],
	"playerdeath": [false, "res://assets/sounds/playerdeath.wav"],
	"miniondeath": [false, "res://assets/sounds/minondeath.wav"],
	"playerhurt": [false, "res://assets/sounds/playerhurt.wav"],
	"teleport": [false, "res://assets/sounds/teleport.wav"],
	"unlock": [false, "res://assets/sounds/unlock.wav"],
	"pause": [false, "res://assets/sounds/unpause.wav"],
	"woosh": [false, "res://assets/sounds/woosh.wav"],
	"win": [false, "res://assets/sounds/winsong.wav"],
	"lose": [false, "res://assets/sounds/losesong.wav"],
	"bossdeath1": [false, "res://assets/sounds/bossdeath1.wav"],
	"bossdeath2": [false, "res://assets/sounds/bossdeath2.wav"],
	"bossdeath3": [false, "res://assets/sounds/bossdeath3.wav"],
	"bossdeath4": [false, null],
	"bossdeath5": [false, null],
	"punch1": [false, "res://assets/sounds/punch1.wav"],
	"punch2": [false, "res://assets/sounds/punch2.wav"],
	"punch3": [false, "res://assets/sounds/punch3.wav"],
	"punch4": [false, "res://assets/sounds/punch4.wav"],
	"necrofight": [false, "res://assets/sounds/necrofight.wav"],
	"execfight": [false, "res://assets/sounds/execfight.wav"],
	"castlesong": [true, "res://assets/sounds/musiccastle.wav"],
	"forestsong": [true, "res://assets/sounds/musicforest.wav"],
	"gravesong": [true, "res://assets/sounds/musicgrave.wav"],
	"mountainsong": [true, "res://assets/sounds/musicmountain.wav"],
	"swampsong": [true, "res://assets/sounds/musicswamp.wav"],
	"menusong": [true, "res://assets/sounds/musicmenu.wav"],
}
const song_themes = { #the second spot in the array is the boss variation
	Tile_Enums.tile_themes_enum.castle: ["castlesong","castlesong"],
	Tile_Enums.tile_themes_enum.forest: ["forestsong","forestsong"],
	Tile_Enums.tile_themes_enum.grave: ["gravesong","gravesong"],
	Tile_Enums.tile_themes_enum.mountain: ["mountainsong","mountainsong"],
	Tile_Enums.tile_themes_enum.swamp: ["swampsong","swampsong"]
}
var audio_streams = {}



func _ready():
	name = "Audio Player"
	for entry in audio_dict:
		if audio_dict[entry][1] == null:
			continue
		var stream = AudioStreamPlayer.new()
		stream.stream = load(audio_dict[entry][1])
		stream.volume_db = default_volume
		stream.name = entry
		audio_streams[entry] = stream
		add_child(stream)
	pass

func play(sound_name):
	if sound_name in audio_streams:
		print("Playing: " + sound_name)
		audio_streams[sound_name].play()
		return
	print("Sound does not exist: " + sound_name)

func stop(sound_name):
	if sound_name in audio_streams:
		print("Stopping: " + sound_name)
		audio_streams[sound_name].stop()
		return
	print("Sound does not exist: " + sound_name)

func stop_all_music():
	for sound in audio_dict:
		if sound in audio_streams:
			if audio_dict[sound][0] == true:
				stop(sound)

func mute_sounds(_sound_name, all_effects: bool, all_music: bool):
	if _sound_name != null:
		if _sound_name in audio_streams:
			audio_streams[_sound_name].volume_db = -80
			return
		print("Sound does not exist: " + _sound_name)
		return
	if all_effects == true:
		for sound in audio_dict:
			if sound in audio_streams:
				if audio_dict[sound][0] == false:
					audio_streams[sound].volume_db = -80
	if all_music == true:
		for sound in audio_dict:
			if sound in audio_streams:
				if audio_dict[sound][0] == true:
					audio_streams[sound].volume_db = -80
	return

func unmute_sounds(_sound_name, all_effects: bool, all_music: bool):
	if _sound_name != null:
		if _sound_name in audio_streams:
			audio_streams[_sound_name].volume_db = default_volume
			return
		print("Sound does not exist: " + _sound_name)
		return
	if all_effects == true:
		for sound in audio_dict:
			if sound in audio_streams:
				if audio_dict[sound][0] == false:
					audio_streams[sound].volume_db = default_volume
	if all_music == true:
		for sound in audio_dict:
			if sound in audio_streams:
				if audio_dict[sound][0] == true:
					audio_streams[sound].volume_db = default_volume
	return
