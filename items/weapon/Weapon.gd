extends Node2D
class_name Weapon

@export var resource: WeaponResource
@onready var actionable: Actionable = $Actionable

func _ready():
	actionable.disable()

func _on_actionable_action(message: Dictionary):
	print("interacted")
