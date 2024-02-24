class_name CoinPopUp extends Node2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var height: float = 10.0
@export var duration: float = 1.0
@onready var _label: Label = $Label

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	$GPUParticles2D.emitting = true
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position:y", global_position.y + height, duration)
	tween.tween_callback(queue_free)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func set_value(value: int):
	_label = $Label
	if value > 0:
		_label.text = "+%s" % value
	elif value == 0:
		_label.text = "%s" % value
	else:
		_label.text = "%s" % value
		_label.add_theme_font_size_override("font_size", 32)
		_label.add_theme_color_override("font_color", Color.RED)
