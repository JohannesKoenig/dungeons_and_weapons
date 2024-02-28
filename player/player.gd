extends CharacterBody2D
class_name Player

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var player_resource: PlayerResource
@onready var quick_access_component: QuickAccessComponent = $QickAccessComponent
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var item_holding_component: ItemHoldingComponent = $ItemHoldingComponent
@onready var hit_player: AudioStreamPlayer2D = $HitPlayer
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var dungeon_inventory: InventoryResource = preload("res://dungeon/dungeon_inventory.tres")
var view_direction: Vector2
var is_ready = false
var _invincibility_timer: Timer

func _ready():
	_invincibility_timer = Timer.new()
	add_child(_invincibility_timer)
	_invincibility_timer.autostart = false
	_invincibility_timer.one_shot = true
	is_ready = true
	unlink_material()
	set_resource(player_resource)
	if !((_message_dispatcher.game_state is DungeonState) or _message_dispatcher.game_state is TavernAfterDungeonState):
		global_position = player_resource.tavern_global_position
		$PlayerCamera.tween_global_pos(global_position)
	_message_dispatcher.game_state_changed.connect(_heal_full)
	if _message_dispatcher.game_state is DayState:
		player_resource.tavern_global_position = global_position
	_heal_full(_message_dispatcher.game_state)
	player_resource.health_resource.died.connect(_on_death)
	if player_resource.health_resource.dead:
		_on_death()
	player_resource.health_resource.damaged.connect(_on_hit)


func set_resource(resource: PlayerResource):
	player_resource = resource
	if is_ready:
		$AnimatedSprite2D.material.set("shader_parameter/head", player_resource.head)
		$AnimatedSprite2D.material.set("shader_parameter/body", player_resource.body)
		$AnimatedSprite2D.material.set("shader_parameter/legs", player_resource.legs)

func unlink_material():
	var material: Material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material = material


func _process(delta):
	move_and_slide()
	if velocity.x != 0:
		view_direction = velocity
	animation_tree["parameters/Walking/blend_position"] = view_direction
	animation_tree["parameters/Idle/blend_position"] = view_direction
	if !(_message_dispatcher.game_state is DungeonState or _message_dispatcher.game_state is DeathState):
		player_resource.tavern_global_position = global_position


func item_change_interaction(to_change: Item):
	if to_change:
		$ItemPickupPlayer.play()
	var selected_item = player_resource.inventory.items[player_resource.quick_access.selected_index]
	if selected_item:
		$ItemDropPlayer.play()
	player_resource.quick_access.replace_item(selected_item, to_change)

func pickup_item(item: Item):
	if item:
		$ItemPickupPlayer.play()

func take_damage(damage: int):
	if _invincibility_timer.is_stopped():
		player_resource.health_resource.take_damage(damage)
		
		_invincibility_timer.start(0.3)

func _heal_full(state: State):
	if state is TavernAfterDungeonState:
		player_resource.health_resource.heal(player_resource.health_resource.max_health)

func _on_death():
	_message_dispatcher.requested_death.emit()

func _on_hit(damage: int):
	hit_player.play()
