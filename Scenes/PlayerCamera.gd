extends Camera2D

@export var tavern_resource: TavernResource = preload("res://tavern/tavern_resource.tres")
@export var tavern_focus_position: Vector2 = Vector2(128,128)
var player_resource: PlayerResource = preload("res://player/player_resource.tres")
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var tween: Tween

func _ready():
	_message_dispatcher.game_state_changed.connect(_on_game_state_changed)
	#_on_game_state_changed(_message_dispatcher.game_state)


func _on_game_state_changed(state: State):
	if state is ShopState:
		tween_global_pos(tavern_focus_position)
	elif state is ReturnState:
		tween_global_pos(player_resource.tavern_global_position)

func tween_global_pos(target: Vector2):
	if tween:
		tween.kill()
	tween = create_tween()
	if tween:
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_parallel(true)
		tween.tween_property(self, "global_position:x", target.x, 0.4)
		tween.tween_property(self, "global_position:y", target.y, 0.4)
			
