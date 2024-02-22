class_name SpeechBubble extends Control

@onready var speaker: Label = $VBoxContainer/Speaker
@onready var line: RichTextLabel = $VBoxContainer/Line
@onready var bleep: AudioStreamPlayer = $Bleep
var data: Dictionary
var tween: Tween
var timer: Timer

var last_visible_characters = 0

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	set_line(data)
	$InputHint.show_hint()

func _physics_process(delta):
	play_speech_bleep()

func set_line(data: Dictionary):
	self.data = data
	if !data or data.is_empty():
		visible = false
		return
	visible = true
	if "speaker" in data:
		if tween:
			tween.kill()
		tween = create_tween()
		line.visible_ratio = 0
		tween.tween_property(line, "visible_ratio", 1, 1)
		line.text = data["line"]
		speaker.text = data["speaker"]
		speaker.visible = true
		var align = data["align"]
		match align:
			"L":
				speaker.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			"R":
				speaker.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
	else:
		speaker.visible = false
	
	line.text = data["line"]
	
func play_speech_bleep():
	var current = line.visible_characters
	if current > last_visible_characters:
		if timer.is_stopped():
			timer.start(0.1)
			bleep.play()
	last_visible_characters = current
