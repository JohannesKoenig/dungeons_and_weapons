extends Node2D
class_name TavernDungeonDoor

@export var day_night_timer: DayNightResource
@export var dungeon_generator_resource: DungeonGeneratorResource = preload("res://dungeon_generator/dungeon_generator_resource.tres")
@export var dungeon_resource: DungeonResource = preload("res://dungeon_spawner/dungeon_resource.tres")
@export var player_resource: PlayerResource = preload("res://player/player_resource.tres")
@onready var game_saver : GameSaver = $"/root/GameSaver"
var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")
var is_open: bool = false
var is_night = false
var tween: Tween
var travel_tween: Tween
@onready var portal_light: PointLight2D = $PortalLight
@onready var effects_area: Area2D = $EffectsArea
@onready var particles: GPUParticles2D = $Particles
@onready var flash: PointLight2D = $Flash


func _ready():
	_message_dispatcher.game_state_changed.connect(update_portal_state)
	update_portal_state(_message_dispatcher.game_state)

func open():
	is_open = true

func close():
	is_open = false

func _on_actionable_action(source):
	if !day_night_timer.is_day and "player" in source.get_groups():
		_message_dispatcher.requested_dungeon.emit()

	if source is Visitor and _message_dispatcher.game_state is ShopState:
		var resource: AdventurerResource = source.adventurer_resource
		# resource.coins = max(0, resource.coins - 10)
		if !resource.is_returning:
			player_resource.set_coins(player_resource.coins + 5)

	if source is Visitor:
		travel_animation()

func flash_portal():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(portal_light, "energy", 2, 0.1)
	tween.tween_property(particles, "amount_ratio", 1, 0)

func return_portal():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(portal_light, "energy", 0, 0.5)
	tween.tween_property(particles, "amount_ratio", 0.1, 0.5)

func travel_animation():
	if travel_tween:
		travel_tween.kill()
	travel_tween = create_tween()
	travel_tween.set_ease(Tween.EASE_IN_OUT)
	travel_tween.tween_property(flash, "energy", 10, 0.05)
	await travel_tween.finished
	if travel_tween:
		travel_tween.kill()
	travel_tween = create_tween()
	travel_tween.set_ease(Tween.EASE_IN_OUT)
	travel_tween.tween_property(flash, "energy", 0, 1)

func _on_effects_area_body_entered(body):
	flash_portal()


func _on_effects_area_body_exited(body):
	if ! has_overlapping():
		return_portal()

func has_overlapping() -> bool:
	return len(effects_area.get_overlapping_bodies()) > 0

func update_portal_state(state: State):
	if state is TavernAfterDungeonState or state is DayState:
		set_inactive()
	else:
		set_active()

func set_inactive():
	$Portal.visible = false
	$AnimatedSprite2D.visible = false
	$PointLight2D2.visible = false
	$Particles.visible = false

func set_active():
	$Portal.visible = true
	$AnimatedSprite2D.visible = true
	$PointLight2D2.visible = true
	$Particles.visible = true
