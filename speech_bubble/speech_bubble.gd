class_name SpeechBubble extends Control

@onready var speaker: Label = $VBoxContainer/Speaker
@onready var line: RichTextLabel = $VBoxContainer/Line
var data: Dictionary
var tween: Tween

func _ready():
	set_line(data)
	$InputHint.show_hint()

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
	
