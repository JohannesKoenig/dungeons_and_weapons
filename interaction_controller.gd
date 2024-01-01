extends Node

# mapping for which target can interact with which interactable
var interaction_map = {}

signal interaction_added(target: Node2D, interactable: Interactable)
signal interaction_removed(target: Node2D, interactable: Interactable)


func add_interactable(target: Node2D, interactable: Interactable):
	if not interaction_map.has(target):
		interaction_map[target] = {}
	interaction_map[target][interactable] = null
	interaction_added.emit(target, interactable)


func remove_interactable(target: Node2D, interactable: Interactable):
	if interaction_map.has(target):
		interaction_map[target].erase(interactable)
	interaction_removed.emit(target, interactable)


func remove_target(target: Node2D):
	interaction_map.erase(target)
