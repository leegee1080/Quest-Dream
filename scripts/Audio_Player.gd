extends Node2D

class_name Audio_Player

#GlobalVars.audio_player.play("placetile") Place this line anywhere I want to place music

const audio_dict = {
#	"song_name": ["is_music: T or F", "file_location"]
	"actionplacetile": [false, "res://assets/sounds/actionplacetile.wav"],
	"click": [false, "res://assets/sounds/click.wav"],
	"coinpickup": [false, "res://assets/sounds/coinpickup.wav"],
	"jump": [false, "res://assets/sounds/jump.wav"],
	"notunlock": [false, "res://assets/sounds/notunlockedyet.wav"],
	"unpause": [false, "res://assets/sounds/pause.wav"],
	"placetile": [false, "res://assets/sounds/placetile.wav"],
	"playerdeath": [false, "res://assets/sounds/playerdeath.wav"],
	"playerhurt": [false, "res://assets/sounds/playerhurt.wav"],
	"teleport": [false, "res://assets/sounds/teleport.wav"],
	"unlock": [false, "res://assets/sounds/unlock.wav"],
	"pause": [false, "res://assets/sounds/unpause.wav"],
	"woosh": [false, "res://assets/sounds/woosh.wav"],
	"bossdeath1": [false, "res://assets/sounds/bossdeath1.wav"],
	"bossdeath2": [false, "res://assets/sounds/bossdeath2.wav"],
	"bossdeath3": [false, "res://assets/sounds/bossdeath3.wav"],
	"bossdeath4": [false, null],
	"bossdeath5": [false, null]
}
var audio_streams = {}

func _ready():
	name = "Audio Player"
	for entry in audio_dict:
		if audio_dict[entry][1] == null:
			continue
		var stream = AudioStreamPlayer.new()
		stream.stream = load(audio_dict[entry][1])
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
