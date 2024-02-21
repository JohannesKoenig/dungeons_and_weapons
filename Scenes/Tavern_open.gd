class_name TavernOpen extends Sprite2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var tavern_closed: Sprite2D
@export var fade_duration: float = 1
var tween: Tween
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	tavern_closed.self_modulate.a = 0

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------



func _on_area_2d_body_entered(body):
	if body is Player:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(tavern_closed, "self_modulate:a", 0, fade_duration)

func _on_area_2d_body_exited(body):
	if body is Player:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(tavern_closed, "self_modulate:a", 1, fade_duration)
