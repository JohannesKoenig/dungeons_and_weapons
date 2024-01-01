extends Node2D
class_name NPCSpawner

@export var spawn_window_duration: float = 20
# @export var spawn_frequency_variance: float = 0
var _characters: Array
var _timer_durations: Array
var timer: Timer
var current_index: int
const CharacterResource = preload("res://Scenes/Game/Units/NPC_movement.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(spawn_character)
	set_characters([
		CharacterModel.new_from_parameters(
			"res://art/sprites/character_commoner_skin.png",
			{
				"general_behaviour": "SHOP",
				"target_shelve": [1,3]
			}
		),
		CharacterModel.new_from_parameters(
			"res://art/sprites/texture_test.png",
			{
				"general_behaviour": "SHOP",
				"target_shelve": [2,3]
			}
		),
		CharacterModel.new_from_parameters(
			"res://art/sprites/character_commoner_skin.png",
			{
				"general_behaviour": "SHOP",
				"target_shelve": [1,1]
			}
		),
		CharacterModel.new_from_parameters(
			"res://art/sprites/texture_test.png",
			{
				"general_behaviour": "ONLY_DUNGEON"
			}
		),
		CharacterModel.new_from_parameters(
			"res://art/sprites/icons/options_icon.png",
			{
				"general_behaviour": "ONLY_DUNGEON"
			}
		),
		CharacterModel.new_from_parameters(
			"res://art/sprites/icons/coin.png",
			{
				"general_behaviour": "ONLY_DUNGEON"
			}
		)
	])
	start_spawning()


func set_characters(characters: Array):
	_characters = characters


func start_spawning():
	_timer_durations = _create_time_table(spawn_window_duration, _characters.size())
	if _timer_durations.size() > 0:
		timer.start(_timer_durations[0])


func spawn_character():
	var character = _characters[current_index]
	instantiate_from_model(character)
	if current_index + 1 < _characters.size():
		current_index += 1
		timer.start(_timer_durations[current_index])


func _create_time_table(duration: float, nr_of_chunks: int) -> Array:
	var table = []
	var equal_chunk_size = duration / (nr_of_chunks + 1)  # add plus 1 to be able to start with a break
	for i in range(nr_of_chunks):
		table.append(equal_chunk_size)
	return table


func instantiate_from_model(character_model: CharacterModel):
	var instance = CharacterResource.instantiate()
	instance.character_model = character_model
	instance.position = Vector2.ZERO
	add_child(instance)
