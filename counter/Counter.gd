extends Node2D

@export var player_resource: PlayerResource
@export var tavern_resource: TavernResource
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var player_on_counter: bool:
	set(value):
		player_on_counter = value
		player_on_counter_changed.emit(value)
signal player_on_counter_changed(value: bool)

func _ready():
	_message_dispatcher.game_state_changed.connect(_on_state_changed)
	_message_dispatcher.game_state_changed.connect(_update_position_marker)
	_on_state_changed(_message_dispatcher.game_state)
	_update_position_marker(_message_dispatcher.game_state)

func interact_buy_item(source: Node2D):
	if source is Player:
		return
	if source is Visitor:
		var adventurer_resource: AdventurerResource = source.adventurer_resource
		var inventory: InventoryResource = adventurer_resource.inventory
		var quick_access: QuickAccessResource = adventurer_resource.quick_access
		var item: Item = inventory.items[quick_access.selected_index]
		# TODO: decide if this makes sense
		# adventurer_resource.coins -= item.value
		sell(item)


func sell(item: Item):
	player_resource.coins += item.value


func interact_open_tavern(source):
	if source is Node and not("player" in source.get_groups()):
		return
	toggle_tavern_open()

func toggle_tavern_open():
	_message_dispatcher.requested_shop_open.emit()
	#tavern_resource.toggle_tavern()

func _on_state_changed(state):
	_update_hint(player_on_counter, state)

func _update_hint(on_counter: bool, state: State):	
	if state is DayState and on_counter:
		$TavernOpen/InputHint.show_hint()
	else:
		$TavernOpen/InputHint.hide_hint()

func _update_position_marker(state: State):
	if state is DayState:
		$AnimatedSprite2D.visible = true
	else:
		$AnimatedSprite2D.visible = false

func _on_tavern_open_is_closest_to_player_changed(value):
	player_on_counter = value
	_update_hint(value, _message_dispatcher.game_state)

