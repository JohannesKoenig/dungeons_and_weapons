extends Control

@export var content: Control
@export var duration: float
@export var fade_duration: float = 0.5
@onready var timer = $Timer


var _tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	content.visible = false
	timer.one_shot = true

func show_content():
	content.visible = true
	timer.start(duration)
	await timer.timeout
	if _tween:
		_tween.kill()
	_tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(self, "modulate:a", 0, fade_duration)
	await _tween.finished
	content.visible = false
	modulate.a = 1
