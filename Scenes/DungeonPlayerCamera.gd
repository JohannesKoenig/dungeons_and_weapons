class_name DungeonPlayerCamera extends Camera2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
var shake_amount: float = 0
var default_offset: Vector2 = offset
var pos_x : int
var pos_y : int

@onready var tween: Tween = create_tween()
var player_resource: PlayerResource = preload("res://player/player_resource.tres")
var timer : Timer

# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	set_process(true)
	add_child(timer)
	player_resource.health_resource.damaged.connect(_on_take_damage)

func _process(delta):
	offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)

func shake(time: float, amount: float):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()

func _on_take_damage(damage: int):
	shake(0.4, 1)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
