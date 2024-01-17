extends Node2D
class_name NPCSpawner

@export var spawn_window_duration: float = 20
var adventurer_resource = preload("res://adventurer/adventurer.tscn")

func _create_time_table(duration: float, nr_of_chunks: int) -> Array:
	var table = []
	var equal_chunk_size = duration / (nr_of_chunks + 1)  # add plus 1 to be able to start with a break
	for i in range(nr_of_chunks):
		table.append(equal_chunk_size)
	return table


func spawn_adventurer() -> Adventurer:
	var adventurer = adventurer_resource.instantiate()
	add_child(adventurer)
	return adventurer
