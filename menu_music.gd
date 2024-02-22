extends BackgroundMusicPlayer

var menu_music: AudioStream = preload("res://audio/MenuTune.wav")

func _ready():
	stream = menu_music
