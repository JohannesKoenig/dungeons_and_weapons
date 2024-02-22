class_name Contract extends AnimatedSprite2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	visible = false
	$Sign.visible = false
	$InputHint.visible = false

# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func show_contract():
	visible = true
	frame = 0
	$Sign.visible = false

func hide_contract():
	visible = false
	$Sign.visible = false

func unroll_contract():
	play()

func show_hint():
	$InputHint.visible = true

func hide_hint():
	$InputHint.visible = false

func sign_contract():
	$Sign.visible = true
	$Sign.play()
