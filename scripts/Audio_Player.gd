extends Node2D

class_name Audio_Player

#GlobalVars.audio_player.play("miniondeath") Place this line anywhere I want to place music

const audio_dict = {
#	"song_name": ["is_music: T or F", "file_location"]
	"actionplacetile": [false, "res://assets/sounds/actionplacetile.wav"],
	"click": [false, "res://assets/sounds/click.wav"],
	"coinpickup": [false, "res://assets/sounds/coinpickup.wav"],
	"consumepickup": [false, "res://assets/sounds/comsumepickup.wav"],
	"jump": [false, "res://assets/sounds/jump.wav"],
	"notunlock": [false, "res://assets/sounds/notunlockedyet.wav"],
	"unpause": [false, "res://assets/sounds/pause.wav"],
	"placetile": [false, "res://assets/sounds/placetile.wav"],
	"playerdeath": [false, "res://assets/sounds/playerdeath.wav"],
	"miniondeath": [false, "res://assets/sounds/minondeath.wav"],
	"playerhurt": [false, "res://assets/sounds/playerhurt.wav"],
	"teleport": [false, "res://assets/sounds/teleport.wav"],
	"unlock": [false, "res://assets/sounds/unlock.wav"],
	"pause": [false, "res://assets/sounds/unpause.wav"],
	"woosh": [false, "res://assets/sounds/woosh.wav"],
	"win": [false, "res://assets/sounds/winstage.wav"],
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
	"execfight": [false, "res://assets/sounds/execfight.wav"]
}
var audio_streams = {}

func _ready():
	name = "Audio Player"
	for entry in audio_dict:
		if audio_dict[entry][1] == null:
			continue
		var stream = AudioStreamPlayer.new()
		stream.stream = load(audio_dict[entry][1])
		stream.volume_db = -25
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
