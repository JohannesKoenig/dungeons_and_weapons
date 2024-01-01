extends Node2D
class_name Interactable

var interaction_area: Area2D
var interactable: bool = false
var interaction_controller: InteractionController
signal interacted


func _ready():
	for child in get_children():
		if child is Area2D:
			interaction_area = child
			break
	interaction_controller = get_node("/root/InteractionController")
	if interaction_area:
		interaction_area.body_entered.connect(_activate_interaction)
		interaction_area.body_exited.connect(_deactivate_interaction)


func _activate_interaction(body: Node2D):
	if interaction_controller:
		interaction_controller.add_interactable(body, self)


func _deactivate_interaction(body: Node2D):
	if interaction_controller:
		interaction_controller.remove_interactable(body, self)


func _get_configuration_warnings():
	var matched_child = null
	for child in get_children():
		if child is Area2D:
			matched_child = child
		break
	if matched_child == null:
		return "Requires CollisionObject2D"


func interact():
	interacted.emit()
