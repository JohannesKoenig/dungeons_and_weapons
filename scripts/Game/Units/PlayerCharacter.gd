extends Node2D

@onready var character: Character = $Character

var direction: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_input()
	character.move(direction)

func _handle_input():
	var vertical = Input.get_axis("up","down")
	var horizontal = Input.get_axis("left", "right")
	direction = Vector2(horizontal, vertical)
