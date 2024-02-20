extends AudioStreamPlayer

var click_sound: AudioStream = preload("res://audio/button_click.wav")
var focus_sound: AudioStream = preload("res://audio/button_focus.wav")

func play_click():
	stream = click_sound
	play()

func play_focus():
	stream = focus_sound
	volume_db = -10
	play()
