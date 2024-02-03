class_name CustomersResource
extends Resource

@export var available: Array
@export var today: Array

var _adventurer_factory = preload("res://adventurer/adventurer_factory.tres")

func get_random_cutstomers(count: int) -> Dictionary:
	var nr_from_available = randi_range(min(count * 0.9, len(available)), min(count, len(available)))
	var duplicated_list = available.duplicate()
	duplicated_list.shuffle()
	var known = duplicated_list.slice(0, nr_from_available)
	var new = []
	for i in range(nr_from_available, count):
		new.append(_adventurer_factory.get_random())
	var adventurers = []
	adventurers.append_array(known)
	adventurers.append_array(new)
	return {
		"known": known,
		"new": new,
		"adventurers": adventurers
	}
