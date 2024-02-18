extends Camera2D

@export var tavern_resource: TavernResource = preload("res://tavern/tavern_resource.tres")
@export var tavern_focus_position: Vector2 = Vector2(128,128)
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

func _ready():
	_message_dispatcher.game_state_changed.connect(_on_game_state_changed)
	_on_game_state_changed(_message_dispatcher.game_state)


func _on_game_state_changed(state: State):
	if state is ShopState:
		global_position = tavern_focus_position
	else:
		global_position = get_parent().global_position
