class_name DungeonDoor
extends Node2D

var _message_dispatcher: MessageDispatcher = preload("res://messaging/MessageDispatcher.tres")

var tween: Tween
@onready var portal_light: PointLight2D = $PortalLight
@onready var effects_area: Area2D = $EffectsArea
@onready var particles: GPUParticles2D = $Particles

func _ready():
	_message_dispatcher.game_state_changed.connect(update_portal_state)
	update_portal_state(_message_dispatcher.game_state)

func _on_area_2d_body_entered(body):
	#get_node("/root/GameSaver").save_game_from_resources()
	if body is Player:
		_message_dispatcher.requested_tavern_after_dungeon.emit()


func flash_portal():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(portal_light, "energy", 2, 0.1)
	tween.tween_property(particles, "amount_ratio", 1, 1)

func return_portal():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(portal_light, "energy", 0, 1)
	tween.tween_property(particles, "amount_ratio", 0.1, 1)


func _on_effects_area_body_entered(body):
	flash_portal()


func _on_effects_area_body_exited(body):
	if ! has_overlapping():
		return_portal()

func has_overlapping() -> bool:
	return len(effects_area.get_overlapping_bodies()) > 0

func update_portal_state(state: State):
	if state is DungeonState or state is DeathState:
		set_active()
	else:
		set_inactive()

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
