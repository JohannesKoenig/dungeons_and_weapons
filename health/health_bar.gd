class_name HealthBar extends Control
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var health_resource: HealthResource = preload("res://player/player_health_resource.tres")
var _hearts: Array = []
var _heart_scene: PackedScene
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	health_resource.damaged.connect(_on_damaged)
	health_resource.healed.connect(_on_healed)
	_heart_scene = load("res://health/health_heart.tscn")
	_init_hearts()
	_on_damaged(health_resource.max_health - health_resource.current_health)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _on_damaged(amount: int):
	var damaged = health_resource.max_health - health_resource.current_health
	for i in range(damaged):
		_hearts[health_resource.max_health - 1 - i].clear()

func _on_healed(amount: int):
	pass

func _init_hearts():
	for i in range(health_resource.max_health):
		var heart = _heart_scene.instantiate()
		add_child(heart)
		_hearts.append(heart)
