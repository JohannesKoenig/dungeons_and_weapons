class_name HealthResource extends Resource
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var max_health = 3
@export var current_health = 3
var dead: bool = false:
	set(value):
		dead = value
		if value:
			died.emit()
signal died
signal damaged(amount: int)
signal healed(amount: int)
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func take_damage(damage: int):
	if current_health - damage <= 0:
		current_health = 0
		dead = true
	else:
		current_health -= damage
	damaged.emit(damage)

func heal(amount: int):
	current_health = min(max_health, current_health + amount)
	healed.emit(amount)
	if current_health > 0:
		dead = false

func serialize() -> Dictionary:
	return {
		"max_health": max_health,
		"current_health": current_health
	}

func deserialize(data: Dictionary):
	max_health = data["max_health"]
	current_health = data["current_health"]
