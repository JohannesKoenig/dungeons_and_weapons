extends Node2D

@onready var character: Character = $Character
@onready var coin_bank: CoinBankComponent = $Character/CoinBankComponent

signal coins_changed(value)

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
	if Input.is_action_just_pressed("action"):
		var actionables = character.actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].trigger({
				"callback": _get_cash
			})

func _get_cash(value: int) -> void:
	coin_bank.add(value)
	coins_changed.emit(coin_bank.value)

