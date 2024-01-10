extends Node2D
class_name Weapon

@export var price: int = 10

func _ready():
	$InteractionPromp.visible = false

func sell():
	visible = false
	$Actionable.disable()
	await get_tree().create_timer(2).timeout
	visible = true
	$Actionable.enable()

func _on_actionable_action(message: Dictionary):
	var callback = message["callback"]
	callback.call(price)
	sell()


func _on_actionable_area_entered(area):
	$InteractionPromp.visible = true

func _on_actionable_area_exited(area):
	$InteractionPromp.visible = false
