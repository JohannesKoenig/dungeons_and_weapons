extends TextureRect

var tween: Tween
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
@onready var filler: TextureRect = $TextureRect
@onready var label: Label = $Label
var _filler_color: Color
func _ready():
	visible = false
	_filler_color = modulate
	_message_dispatcher.game_state_changed.connect(_on_state_changed)
	_on_state_changed(_message_dispatcher.game_state)

func fade_in(duration: float):
	visible = true
	if tween:
		tween.kill()
	texture.fill_to = Vector2(1,0)
	filler.modulate.a = 0
	label.modulate.a = 0
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(texture, "fill_to:x", 0.5, duration)
	tween.tween_property(texture, "fill_to:y", 0.5, duration)
	tween.tween_property(filler, "modulate:a", 1, duration)
	tween.tween_property(label, "modulate:a", 1, duration)
	tween.tween_callback(func(): filler.modulate = Color.BLACK).set_delay(duration)


func fade_out(duration: float):
	if tween:
		tween.kill()
	texture.fill_to = Vector2(0.5,0.5)
	filler.modulate = _filler_color
	filler.modulate.a = 1
	label.modulate.a = 1
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(texture, "fill_to:x", 1, duration)
	tween.tween_property(texture, "fill_to:y", 0, duration)
	tween.tween_property(filler, "modulate:a", 0, duration)
	tween.tween_property(label, "modulate:a", 0, duration)
	await tween.finished
	visible = false

func _on_state_changed(state: State):
	if state is DeathState:
		fade_in(2)
