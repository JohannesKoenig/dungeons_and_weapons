extends Node2D
class_name Weapon


func _ready():
	$InteractionPromp.visible = false

func sell():
	print("sold for X gold")
	visible = false
	$Actionable.disable()
	await get_tree().create_timer(2).timeout
	visible = true
	$Actionable.enable()

func _on_actionable_action():
	sell()


func _on_actionable_area_entered(area):
	print("test")
	$InteractionPromp.visible = true

func _on_actionable_area_exited(area):
	$InteractionPromp.visible = false
