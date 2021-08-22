extends Node2D

class_name Audio_Player

#GlobalVars.audio_player.play("hit1") Place this line anywhere I want to place music

const audio_dict = {
#	"song_name": ["is_music: T or F", "file_location"]
	"hit1": [false, "res://assets/sounds/hit1.wav"],
	"hit2": [false, "res://assets/sounds/hit2.wav"],
	"hit3": [false, "res://assets/sounds/hit3.wav"],
	"oof": [false, "res://assets/sounds/oof.wav"],
	"proj1": [false, "res://assets/sounds/proj1.wav"],
	"proj2": [false, "res://assets/sounds/proj2.wav"],
	"proj3": [false, "res://assets/sounds/proj3.wav"],
	"coin": [false, null],
	"health": [false, null],
	"necro": [false, null],
	"woosh": [false, null]
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
