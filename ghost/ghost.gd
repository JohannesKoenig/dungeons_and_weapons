class_name Ghost extends CharacterBody2D
# ------------------------------------------------------------------------------
# Variables ====================================================================
# ------------------------------------------------------------------------------
@export var target: Node2D
@export var damage: int = 1
var spawn_point: Vector2 = Vector2(0, 3 * 128 + 64)
var bounce_velocity: Vector2
var recall_duration = 1.0
var start_time: float
var timer: Timer
var active = false
var dnr: DayNightResource = preload("res://daynight/day_night_resource.tres")
var state: String:
	set(value):
		if value != state:
			on_state_changed.emit(value)
		state = value
signal on_state_changed(value: String)
@onready var rage_particles: GPUParticles2D = $EnrageParticle
@onready var attack_sounds: AudioStreamPlayer2D = $AttackSounds
@onready var run_sounds: AudioStreamPlayer2D = $RunSounds
@onready var enrage_sounds: AudioStreamPlayer2D = $EnrageSounds
@onready var enrage_start_sounds: AudioStreamPlayer2D = $EnrageStartSounds
# ------------------------------------------------------------------------------
# Live Cycle ===================================================================
# ------------------------------------------------------------------------------
func _ready():
	$MovementMapper.target = target
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	visible = false
	dnr.time_changed.connect(_activate)
	_activate(dnr.is_day, dnr.current_hours, dnr.current_minutes)
	on_state_changed.connect(update_sounds_on_state)


func _physics_process(delta):
	if active:
		match(state):
			"attack":
				_attack(delta)
			"run":
				_run_away(delta)
			"enrage":
				_enrage(delta)
		
# ------------------------------------------------------------------------------
# Class Functions ==============================================================
# ------------------------------------------------------------------------------
func _activate(is_day: bool, hour: int, minute: int):
	if 0 <= hour and hour < 7 and active == false:
		# Spawn outside of window and always 250 px away
		global_position = (spawn_point - target.global_position).normalized() * 150 + target.global_position
		active = true
		visible = true
	if 0 <= hour and hour < 4:
		state = "attack"
		return
	elif hour == 4 and 0 <= minute and minute < 30:
		state = "run"
		return
	elif (4 == hour and 30 <= minute and minute < 60) or (5 < hour and hour < 6):
		state = "enrage"
		if !rage_particles.emitting:
			rage_particles.emitting = true
		modulate = Color.RED
		$FlickeringLight.color = Color.RED
		return
	

func _attack(delta):
	var bounce_to_add = Vector2.ZERO
	if not timer.is_stopped():
		bounce_to_add = lerp(bounce_velocity, Vector2.ZERO, 1-timer.time_left/recall_duration)
	var collision = move_and_collide((velocity + 6*bounce_to_add) * delta)
	var collision_count = 0
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			collider.take_damage(damage)
		var normal = collision.get_normal()
		bounce_velocity = velocity.bounce(normal)
		timer.start(recall_duration)

func _run_away(delta):
	velocity = -velocity * 4
	move_and_slide()

func _enrage(delta):
	velocity = 4 * velocity
	var bounce_to_add = Vector2.ZERO
	if not timer.is_stopped():
		bounce_to_add = lerp(bounce_velocity, Vector2.ZERO, 1-timer.time_left/recall_duration)
	var collision = move_and_collide((velocity + 6*bounce_to_add) * delta)
	var collision_count = 0
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			collider.take_damage(damage)
		var normal = collision.get_normal()
		bounce_velocity = velocity.bounce(normal) / 3
		timer.start(recall_duration)

func update_sounds_on_state(state: String):
	match(state):
		"attack":
			play_attack_sounds()
		"run":
			stop_attack_sounds()
			play_run_sounds()
		"enrage":
			play_enrage_sounds()

func play_attack_sounds():
	attack_sounds.play()
	attack_sounds.finished.connect(attack_sounds.play)

func stop_attack_sounds():
	attack_sounds.stop()

func play_run_sounds():
	run_sounds.play()

func play_enrage_sounds():
	enrage_start_sounds.play()
	enrage_sounds.play()
	enrage_sounds.finished.connect(enrage_sounds.play)

func stop_enrage_sounds():
	enrage_sounds.stop()
