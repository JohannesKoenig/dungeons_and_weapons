class_name FlickeringLight extends PointLight2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var flicker_delta = 0.1
@export var flicker_time = 1.0
@onready var _without_shadow = $PointLight2D
var _tween: Tween
var _texture_scale: Vector2

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	_texture_scale = scale
	_without_shadow.energy = energy
	_without_shadow.color = color
	_next_tween()
	

func _process(delta):
	if !_tween.is_running():
		_next_tween()
# ------------------------------------------------------------------------------
func _next_tween():
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_parallel(true)
	var scale_delta = randf_range(-flicker_delta, flicker_delta)
	_tween.tween_property(
		self,
		"scale:x",
		_texture_scale.x + (_texture_scale.x * scale_delta),
		flicker_time
	)
	_tween.tween_property(
		self,
		"scale:y",
		_texture_scale.y + (_texture_scale.y * scale_delta),
		flicker_time
	)
