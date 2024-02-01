class_name CustomersResource
extends Resource

@export var available: Array
@export var today: Array

var _adventurer_factory = preload("res://adventurer/adventurer_factory.tres")

func get_random_cutstomers(count: int) -> Array:
	var nr_from_available = randi_range(0, min(count, len(available)))
	var duplicated_list = available.duplicate()
	duplicated_list.shuffle()
	var adventurers = duplicated_list.slice(0, nr_from_available)
	for i in range(nr_from_available, count):
		adventurers.append(_adventurer_factory.get_random())
	return adventurers
