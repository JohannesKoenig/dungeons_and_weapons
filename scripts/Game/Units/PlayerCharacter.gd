extends Node2D

@onready var character: Character = $Character
@onready var coin_bank: CoinBankComponent = $Character/CoinBankComponent
@export var weapon: Weapon

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
			var actionable_name = actionables[0].actionable_name
			match actionable_name:
				"ItemDisplay":
					actionables[0].trigger({
						"on_success": remove_weapon
					})

func _get_cash(value: int) -> void:
	coin_bank.add(value)
	coins_changed.emit(coin_bank.value)

func hold_weapon(weapon: Weapon) -> void:
	self.weapon = weapon
	add_child(weapon)
	weapon.set_position(position)

func remove_weapon() -> Weapon: 
	remove_child(weapon)
	var weapon = self.weapon
	self.weapon = null
	return weapon
